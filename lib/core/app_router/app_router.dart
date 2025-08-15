import 'package:flutter/material.dart';
import 'package:holo_challenge/modules/products/list/products_screen.dart';
import 'package:holo_challenge/utils/app_logger.dart';

import 'route_names.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final String? path = settings.name;
    try {
      switch (path) {
        case RouteNames.products:
          final args = settings.arguments as ProductsScreenParams?;
          return _materialPageRoute(ProductsScreen(params: args));

        default:
          return _noRouteWidget(path);
      }
    } catch (e) {
      AppLogger.log('onGenerateRoute $path error: $e', LoggingType.error);
      return _noRouteWidget(path);
    }
  }

  static Route _materialPageRoute(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }

  static Route _noRouteWidget(String? path) {
    return _materialPageRoute(
      Scaffold(body: Center(child: Text('No route defined for screen $path'))),
    );
  }
}
