import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:holo_challenge/core/constants/api_endpoints.dart';
import 'package:holo_challenge/core/localization/app_localization.dart';
import 'package:holo_challenge/utils/app_logger.dart';
import 'package:holo_challenge/utils/network_utils.dart';
import 'package:holo_challenge/widgets/loader/custom_toast.dart';
import 'package:holo_challenge/widgets/loader/loading_dialog.dart';
import 'package:http/http.dart' as http;

enum ApiMethod { get, post, put, patch, delete }

class ApiService {
  static const String _baseUrl = ApiEndpoints.baseUrl;
  static const timeOut = 30;

  static Future<dynamic> request({
    required ApiMethod method,
    required String endpoint,
    int? id,
    Map<String, dynamic>? data,
    Function(Map<String, dynamic>)? fromJson,
    bool showLoader = false,
    bool showSuccessMessage = false,
  }) async {
    try {
      bool isInternetAvailable = await NetworkUtils.isInternetAvailable();
      if (!isInternetAvailable) {
        _showErrorMessage(
          AppLocalizations.getLocalization().noInternetConnection,
        );
        return null;
      }

      final uri = Uri.parse('$_baseUrl$endpoint${id != null ? '/$id' : ''}');
      final headers = _getHeaders();

      AppLogger.log(
        "API ${method.name.toUpperCase()}: $uri\n"
        "${data != null ? 'Body: ${jsonEncode(data)}' : ''}",
        LoggingType.info,
      );

      if (showLoader) LoadingDialog.show();

      final response = await _executeRequest(
        method: method,
        uri: uri,
        headers: headers,
        data: data,
      ).timeout(const Duration(seconds: timeOut));

      if (showLoader) LoadingDialog.dismiss();

      AppLogger.log(
        "API Response (${response.statusCode}): ${response.body}",
        LoggingType.info,
      );

      return _handleResponse(
        response: response,
        fromJson: fromJson,
        showSuccessMessage: showSuccessMessage,
      );
    } on TimeoutException {
      _showErrorMessage(
        AppLocalizations.getLocalization().serverTakingLongRespond,
      );
      return null;
    } on SocketException {
      _showErrorMessage(
        AppLocalizations.getLocalization().noInternetConnection,
      );
      return null;
    } catch (e) {
      AppLogger.log("API Error: $e", LoggingType.error);
      _showErrorMessage(AppLocalizations.getLocalization().somethingWentWrong);
      return null;
    }
  }

  static Future<http.Response> _executeRequest({
    required ApiMethod method,
    required Uri uri,
    required Map<String, String> headers,
    Map<String, dynamic>? data,
  }) async {
    switch (method) {
      case ApiMethod.get:
        return http.get(uri, headers: headers);
      case ApiMethod.post:
        return http.post(uri, headers: headers, body: jsonEncode(data));
      case ApiMethod.put:
        return http.put(uri, headers: headers, body: jsonEncode(data));
      case ApiMethod.patch:
        return http.patch(uri, headers: headers, body: jsonEncode(data));
      case ApiMethod.delete:
        return http.delete(uri, headers: headers);
    }
  }

  static dynamic _handleResponse({
    required http.Response response,
    Function(Map<String, dynamic>)? fromJson,
    bool showSuccessMessage = false,
  }) {
    if (response.body.isEmpty) {
      return true; // For empty responses (e.g., DELETE)
    }

    final body = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (showSuccessMessage) {
        _showSuccessMessage("Success");
      }

      if (fromJson != null) {
        return body is List
            ? body.map((item) => fromJson(item)).toList()
            : fromJson(body);
      }
      return body;
    } else {
      _showErrorMessage(_parseError(response));
      return null;
    }
  }

  static String _parseError(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      return body['message'] ?? response.reasonPhrase ?? 'Unknown error';
    } catch (e) {
      return response.reasonPhrase ?? 'Failed to parse error';
    }
  }

  static void _showSuccessMessage(String message) {
    CustomToast.show(message, type: ToastType.success);
  }

  static void _showErrorMessage(String message) {
    LoadingDialog.dismiss();
    CustomToast.show(message);
  }

  static Map<String, String> _getHeaders() {
    return {'Content-Type': 'application/json', 'Accept': 'application/json'};
  }
}
