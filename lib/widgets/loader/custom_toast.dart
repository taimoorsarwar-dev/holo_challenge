import 'package:flutter/material.dart';
import 'package:holo_challenge/r.dart';
import 'package:holo_challenge/widgets/image/multi_source_image.dart';
import 'package:oktoast/oktoast.dart';

import '../../core/theme/ui_theme.dart';

enum ToastType { success, error, generic }

class _ToastConfig {
  final Color? backgroundColor;
  final Color? textColor;
  final String? iconAsset;
  final bool hasIconCircle;

  const _ToastConfig({
    this.backgroundColor,
    this.textColor,
    this.iconAsset,
    this.hasIconCircle = false,
  });
}

class CustomToast {
  static final Color? _successColor = ThemePalette.successGreenMessage;
  static final Color? _errorColor = ThemePalette.errorRedMessage;
  // static final Color? _warningColor = ThemePalette.orange;
  static const double _offset = 30;
  static const int _duration = 3; // seconds

  static void dismissAll() => dismissAllToast();

  static Future<void> show(
    String? message, {
    ToastType type = ToastType.error, // Default to error
  }) async {
    showToastWidget(
      _ToastWidget(message: message, toastType: type),
      dismissOtherToast: true,
      duration: const Duration(seconds: _duration),
      position: ToastPosition(align: Alignment.topCenter, offset: _offset),
    );
  }

  static Future<void> showSimple(
    String? message, {
    bool isSuccess = false,
  }) async {
    showToast(
      message ?? '',
      dismissOtherToast: true,
      duration: Duration(seconds: _duration),
      margin: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: isSuccess ? _successColor : _errorColor,
      position: ToastPosition(align: Alignment.topCenter, offset: _offset),
      textStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
      textPadding: EdgeInsets.all(15),
      textOverflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      textMaxLines: 2,
      radius: 6,
    );
  }
}

class _ToastWidget extends StatelessWidget {
  final String? message;
  final ToastType? toastType;

  const _ToastWidget({this.message, this.toastType});

  static _ToastConfig _getToastConfigs(ToastType? type) {
    switch (type) {
      case ToastType.generic:
        return _ToastConfig(
          backgroundColor: ThemePalette.cellBackgroundColor,
          textColor: ThemePalette.primaryText,
          // iconAsset: R.assetsImagesIconsTick,
          // hasIconCircle: true,
        );
      case ToastType.success:
        return _ToastConfig(
          backgroundColor: ThemePalette.successGreenMessage,
          textColor: ThemePalette.selectedTextColor,
          iconAsset: R.assetsImagesIconsCompleted,
        );
      case ToastType.error:
        return _ToastConfig(
          backgroundColor: ThemePalette.errorRedMessage,
          textColor: ThemePalette.selectedTextColor,
          iconAsset: R.assetsImagesIconsCancel,
        );
      default:
        return _ToastConfig(
          backgroundColor: ThemePalette.errorRedMessage,
          textColor: ThemePalette.selectedTextColor,
          iconAsset: R.assetsImagesIconsCancel,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the configuration for the given loader type.
    final _ToastConfig config = _getToastConfigs(toastType);

    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: config.backgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(0, 2),
            color: ThemePalette.inActiveBgColor.withOpacity(0.5),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildIcon(config),
          UIHelper.horizontalSpaceSmall,
          _buildMessage(config),
        ],
      ),
    );
  }

  /// Builds the icon part of the loader.
  Widget _buildIcon(_ToastConfig config) {
    final double iconSize = 24.0;
    Widget icon = MultiSourceImage(
      url: config.iconAsset ?? R.assetsImagesIconsCancel,
      iconColor:
          config.hasIconCircle
              ? ThemePalette.cellBackgroundColor
              : config.textColor,
    );

    if (config.hasIconCircle) {
      return Container(
        height: iconSize,
        width: iconSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ThemePalette.accentColor,
        ),
        padding: const EdgeInsets.all(3),
        child: icon,
      );
    }

    return SizedBox(height: iconSize, width: iconSize, child: icon);
  }

  /// Builds the text message part of the loader.
  Widget _buildMessage(_ToastConfig config) {
    return Expanded(
      child: Text(
        message ??
            'An unexpected error occurred.', // Provide a fallback message
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        maxLines: 2,
        style: AppTextStyle.getLargeTextStyle(
          false, // This parameter seems unused, consider removing it
          config.textColor ?? ThemePalette.cellBackgroundColor,
          FontType.medium,
        ),
      ),
    );
  }
}
