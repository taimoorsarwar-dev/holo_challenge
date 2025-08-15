import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

enum LoggingType { error, warning, info, debug }

class AppLogger {
  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      colors: true,
      printEmojis: true,
    ),
  );

  static void log(String message, LoggingType type) {
    if (kReleaseMode) return;
    _dispatchLog(message, type);
  }

  static void logObject(Object object) {
    if (kReleaseMode) return;
    dev.log(object.toString());
  }

  static void _dispatchLog(String message, LoggingType type) {
    switch (type) {
      case LoggingType.error:
        _logger.e(message);
        break;
      case LoggingType.warning:
        _logger.w(message);
        break;
      case LoggingType.info:
        _logger.i(message);
        break;
      case LoggingType.debug:
        _logger.d(message);
        break;
    }
  }
}
