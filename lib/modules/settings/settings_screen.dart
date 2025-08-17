import 'package:flutter/material.dart';
import 'package:holo_challenge/core/di/app_locator.dart';
import 'package:holo_challenge/core/localization/app_localization.dart';
import 'package:holo_challenge/core/theme/ui_theme.dart';
import 'package:holo_challenge/modules/base/base_bloc.dart';
import 'package:holo_challenge/modules/base/base_state.dart';
import 'package:holo_challenge/modules/user/user_preferences_bloc.dart';
import 'package:holo_challenge/utils/ui_util.dart';

import 'settings_bloc.dart';

class SettingsScreenParams {
  final int tabIndex;
  final bool isLaunchedInTab;
  SettingsScreenParams(this.tabIndex, this.isLaunchedInTab);
}

class SettingsScreen extends StatefulWidget {
  final SettingsScreenParams? params;

  const SettingsScreen({super.key, this.params});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends BaseState<SettingsScreen> {
  SettingsBloc? _settingsBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    createBloc();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _settingsBloc?.dispose();
    super.dispose();
  }

  bool createBloc() {
    if (_settingsBloc == null) {
      _settingsBloc = SettingsBloc();
      _settingsBloc?.setTitle(
        title: AppLocalizations.getLocalization().settings,
      );

      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryDate = MediaQuery.of(context);
    AppResponsive.isSmallDevice(mediaQueryDate);
    AppResponsive.isTablet(mediaQueryDate);

    if (_settingsBloc == null) {
      return Container();
    }
    return Scaffold(
      backgroundColor: ThemePalette.backgroundColor,
      body: BlocProvider<SettingsBloc>(
        bloc: _settingsBloc,
        child: SafeArea(child: _getBaseContainer()),
      ),
    );
  }

  Widget _getBaseContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        getAppBarWidget(
          titleStream: _settingsBloc?.titleStream,
          isBackNeeded: widget.params?.isLaunchedInTab == false ? true : false,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: UIHelper.largePadding,
              vertical: UIHelper.mediumPadding,
            ),
            child: _getBody(),
          ),
        ),
        UIHelper.verticalSpaceSmall,
      ],
    );
  }

  Widget _getBody() {
    return Container(
      decoration: BoxDecoration(
        color: ThemePalette.cellBackgroundColor,
        borderRadius: UIHelper.getBorderRadius(radius: UIHelper.smallRadius),
      ),
      padding: const EdgeInsets.all(UIHelper.mediumPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getTitleWidget(
            title: AppLocalizations.getLocalization().preferences,
          ),
          UIHelper.verticalSpaceMedium,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [_getThemeWidget()],
          ),
        ],
      ),
    );
  }

  Widget _getThemeWidget() {
    return StreamBuilder(
      stream: _settingsBloc?.selectedTheme,
      builder: (context, asyncSnapshot) {
        CustomTheme theme = locator<UserPreferencesBloc>().getSelectedTheme();

        if (asyncSnapshot.hasData && asyncSnapshot.data is CustomTheme) {
          theme = asyncSnapshot.data as CustomTheme;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getLabelWidget(
              label: AppLocalizations.getLocalization().darkTheme,
            ),
            UiUtils.getToggleSwitch(
              selectedValue: theme == CustomTheme.dark,
              onChanged: (value) {
                _settingsBloc?.manageTheme(isDarkTheme: value);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getTitleWidget({String? title}) {
    if (title != null && title.isNotEmpty) {
      return Text(
        title,
        style: AppTextStyle.getLargeTextStyle(
          false,
          ThemePalette.primaryText,
          FontType.bold,
        ),
      );
    }

    return Container();
  }

  Widget _getLabelWidget({String? label}) {
    if (label != null && label.isNotEmpty) {
      return Text(
        label,
        style: AppTextStyle.getMediumTextStyle(
          false,
          ThemePalette.primaryText,
          FontType.medium,
        ),
      );
    }

    return Container();
  }
}
