import 'package:flutter/material.dart';
import 'package:holo_challenge/utils/app_logger.dart';

import 'route_names.dart';

class NavigatorService {
  /// Global Navigator key to access context from anywhere
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Get current context safely
  static BuildContext get currentContext => navigatorKey.currentContext!;

  static OverlayState get overlayState => navigatorKey.currentState!.overlay!;

  static BuildContext get overlayContext => overlayState.context;

  /// Push named route
  static Future<void> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
    void Function(T? result)? onResult,
  }) async {
    try {
      final result = await navigatorKey.currentState!.pushNamed<T>(
        routeName,
        arguments: arguments,
      );

      if (onResult != null) {
        onResult(result);
      }
    } catch (e) {
      AppLogger.log(
        'NavigatorService.pushNamed error: $e',
        LoggingType.warning,
      );
    }
  }

  /// Replace with named route
  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  /// Pop current route
  static void pop<T extends Object?>({T? result}) {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop(result);
    }
  }

  /// Pop until a route is reached
  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  /// Show a bottom sheet
  static Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: navigatorKey.currentContext!,
      elevation: 0,
      enableDrag: enableDrag,
      useRootNavigator: useRootNavigator,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      builder: (context) => child,
    ).then((value) {
      return value;
    });
  }

  /// Close current bottom sheet
  static void closeBottomSheet<T extends Object?>({T? result}) {
    Navigator.of(overlayContext).pop(result);
  }

  /// Show a dialog
  static Future<T?> showDialogBox<T>({
    required Widget child,
    bool barrierDismissible = true,
    bool useRootNavigator = false,
  }) {
    return showDialog<T>(
      context: overlayContext,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (context) => child,
    );
  }

  /// Close dialog
  static void closeDialog<T extends Object?>({
    T? result,
    bool useRootNavigator = false,
  }) {
    Navigator.of(overlayContext, rootNavigator: useRootNavigator).pop(result);
  }

  /// Pop everything until root
  static void popToRoot() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  /// Show snackbar (bonus)
  static void showSnackbar(String message) {
    ScaffoldMessenger.of(
      overlayContext,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static void navigateHomeByUserType() {
    pushNamedAndRemoveUntil(RouteNames.products);
  }
}
