import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static Future<bool> isInternetAvailable() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types
      return false;
    }

    // For any other connectivity type, check if we can reach a reliable website
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Internet is available
      } else {
        return false; // DNS lookup failed, so no internet
      }
    } catch (_) {
      return false; // Network request failed, no internet
    }
  }
}
