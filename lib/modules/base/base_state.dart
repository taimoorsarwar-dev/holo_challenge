import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holo_challenge/core/app_router/navigator_service.dart';
import 'package:holo_challenge/core/theme/app_responsive.dart';
import 'package:holo_challenge/core/theme/app_text_styles.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';
import 'package:holo_challenge/core/theme/ui_helper.dart';
import 'package:holo_challenge/r.dart';
import 'package:holo_challenge/widgets/buttons/custom_icon_button.dart';
import 'package:holo_challenge/widgets/image/multi_source_image.dart';

extension CapExtension on String {
  String get inCaps =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get allInCaps => toUpperCase();

  String get capitalizeFirstOfEach => replaceAll(
    RegExp(' +'),
    ' ',
  ).split(" ").map((str) => str.inCaps).join(" ");

  String get capitalize =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}

abstract class BaseState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double appBarPrefixSize = UIHelper.appBarButtonHeight;

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    _portraitModeOnly();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool backIsPressed() {
    final navigator = NavigatorService.navigatorKey.currentState!;

    // If navigator can pop, pop the current route
    if (navigator.canPop()) {
      NavigatorService.pop();
    }
    return true;
  }

  void onBackPressed({dynamic result}) {
    NavigatorService.pop(result: result);
  }

  // blocks rotation; sets orientation to: portrait
  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Widget getAppBarWidget({
    Stream<String>? titleStream,
    String? title,
    Color? backgroundColor,
    bool isBackNeeded = false,
    Color? appBarTextColor,
    Widget? leadingWidget,
    List<Widget>? suffixWidgets,
    bool needLeadingWidgetLeftPadding = false,
  }) {
    appBarTextColor ??= ThemePalette.primaryText;

    if (isBackNeeded == true) {
      leadingWidget = Container(
        margin: const EdgeInsets.only(
          left: UIHelper.smallPadding,
          right: UIHelper.spaceEight,
        ),
        child: getBackButton(color: appBarTextColor),
      );
    } else if (leadingWidget != null) {
      leadingWidget = Container(
        margin: const EdgeInsets.only(
          left: UIHelper.largePadding,
          right: UIHelper.smallPadding,
        ),
        child: leadingWidget,
      );
    } else {
      leadingWidget = const SizedBox(width: UIHelper.largePadding);
    }
    return StreamBuilder<dynamic>(
      stream: titleStream,
      builder: (context, snapshot) {
        String? appBarTitle = title ?? "";
        if (snapshot.hasData && snapshot.data is String) {
          appBarTitle = snapshot.data as String;
        }

        return SafeArea(
          top: true,
          bottom: false,
          child: Container(
            height: AppResponsive.isDeviceTablet ? 66 : kToolbarHeight,
            color: backgroundColor,
            margin: const EdgeInsets.only(right: UIHelper.extraSmallPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (leadingWidget != null) leadingWidget,
                if (appBarTitle.isNotEmpty)
                  Expanded(
                    child: Text(
                      appBarTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.getExtraLargeTextStyle(
                        false,
                        appBarTextColor!,
                        FontType.bold,
                      ),
                    ),
                  ),
                UIHelper.horizontalSpaceExtraSmall,
                if (suffixWidgets != null && suffixWidgets.isNotEmpty)
                  Row(children: suffixWidgets),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getBackButton({Color? color, bool needRightPadding = true}) {
    return CustomIconButton(
      isTransparent: true,
      icon: R.assetsImagesIconsArrowLeft,
      onTap: onBackPressed,
      iconColor: color,
      size: appBarPrefixSize,
      buttonIconSize: ButtonIconSize.large,
    );
  }

  /* void exitApp() {
    ConfirmationDialog customDialog = ConfirmationDialog(
      negativeIsClicked: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      positiveIsClicked: () {},
      positiveBtnText: AppLocalizations.getLocalization().stay,
      negativeBtnText: AppLocalizations.getLocalization().exit,
      title: AppLocalizations.getLocalization().alert,
      subTitle: AppLocalizations.getLocalization().exitAppAlert,
    );

    NavigatorService.showDialogBox(child: customDialog);
  }*/
}
