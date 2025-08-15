import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppResponsive {
  static const comparableHeight = 1000;
  static const comparableWidth = 600;
  static bool isDeviceTablet = false;
  static bool isSmallScreenDevice = false;
  static double heightOfTheDevice = 0;
  static double widthOfTheDevice = 0;
  static const webThreshold = 1000;

  bool isDeviceSizeSet = false;

  static bool isTablet(MediaQueryData query) {
    var size = query.size;
    heightOfTheDevice = size.height;
    widthOfTheDevice = size.width;
    var diagonal =
        sqrt((size.width * size.width) + (size.height * size.height));

    double width = size.width > size.height ? size.height : size.width;
    bool isTablet = false;
    if (width > 600 && diagonal > 1100.0) {
      isTablet = true;
    }
    isDeviceTablet = isTablet;
    return isTablet;
  }

  static bool isSmallDevice(MediaQueryData query) {
    var size = query.size;
    if (size.height < 600) {
      //this device is iPhone 5 s or 4s ro smaller screen android devices
      isSmallScreenDevice = true;
      return true;
    }
    isSmallScreenDevice = false;
    return false;
  }

  static double getSizeOf(double size) {
    double result = (size * heightOfTheDevice) / comparableHeight;
    // if (Platform.isIOS) result = result + 5;
    return result;
  }

  static double getFontSizeOf(double size) {
    double result = size;

    double unitHeightValue = heightOfTheDevice * 0.001;

    if (isDeviceTablet) {
      result = size * unitHeightValue;
    } else if (kIsWeb) {
      result = size * unitHeightValue;
    } else {
      result = size;
    }

    return result;
  }
}
