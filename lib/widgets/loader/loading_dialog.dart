import 'package:flutter/material.dart';
import 'package:holo_challenge/core/app_router/navigator_service.dart';
import 'package:holo_challenge/modules/base/custom_pop_scope.dart';
import 'package:holo_challenge/utils/app_logger.dart';

import 'loader_widget.dart';

class LoadingDialog {
  static bool _isDialogOpen = false;

  static Future show() async {
    try {
      _isDialogOpen = true;
      BuildContext context = NavigatorService.overlayContext;
      double height = MediaQuery.of(context).size.height * 0.15;
      double width = MediaQuery.of(context).size.width * 0.5;

      await NavigatorService.showDialogBox(
        child: CustomPopScope(
          canPop: true,
          child: UnconstrainedBox(
            child: SizedBox(
              height: height,
              width: width,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(child: const LoaderWidget()),
              ),
            ),
          ),
        ),
        // barrierDismissible: false,
      ).then((_) {
        _isDialogOpen = false;
      });
      _isDialogOpen = false;
    } catch (e) {
      AppLogger.log("LoadingDialog show error: $e", LoggingType.error);
    }
  }

  static void dismiss() {
    if (_isDialogOpen) {
      NavigatorService.closeDialog();
      _isDialogOpen = false;
    }
  }
}
