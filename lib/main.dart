import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:holo_challenge/utils/app_logger.dart';
import 'package:oktoast/oktoast.dart';

import 'core/app_router/app_router.dart';
import 'core/app_router/navigator_service.dart';
import 'core/app_router/route_names.dart';
import 'core/config/supported_lang.dart';
import 'core/constants/app_constants.dart';
import 'core/di/app_locator.dart';
import 'core/localization/app_localization.dart';
import 'core/theme/theme_palette.dart';
import 'modules/user/user_preferences_bloc.dart';
import 'modules/user/user_preferences_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(AppLang(SupportedLang.english));

  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initSplashScreen() async {
    try {
      await Future.delayed(
        const Duration(seconds: 3),
      ).then((value) => FlutterNativeSplash.remove());
    } catch (e) {
      AppLogger.log(e.toString(), LoggingType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: locator<UserPreferencesBloc>().userPrefStream,
      builder: (context, snapshot) {
        _initSplashScreen();
        Locale appLocale = locator<UserPreferencesBloc>().getCurrentLocale();
        int id = 0;
        if (snapshot.hasData && snapshot.data is UserPreferencesModel) {
          UserPreferencesModel userPreferencesModel = snapshot.data;
          appLocale = userPreferencesModel.appLang.locale;
          id = userPreferencesModel.id!;
        }

        return Container(
          decoration: BoxDecoration(color: Colors.black),
          child: OKToast(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              key: ValueKey(id),
              navigatorKey: NavigatorService.navigatorKey,
              initialRoute: getInitialScreen(),
              onGenerateRoute: AppRouter.onGenerateRoute,
              title: AppConstants.appName,
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: ThemePalette.accentColor,
                  brightness: Brightness.light,
                ),
                canvasColor: ThemePalette.transparentColor,
                unselectedWidgetColor: ThemePalette.primaryText,
                hintColor: ThemePalette.dividerColor,
                textSelectionTheme: TextSelectionThemeData(
                  selectionColor: ThemePalette.accentMedium,
                  selectionHandleColor: ThemePalette.accentColor.withOpacity(
                    0.3,
                  ),
                ),
              ),
              localizationsDelegates: [
                AppLocalizationsDelegate(appLocale),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (_, supportedLocales) {
                for (var supportedLocaleLanguage in supportedLocales) {
                  if (supportedLocaleLanguage.languageCode ==
                      appLocale.languageCode) {
                    return supportedLocaleLanguage;
                  }
                }

                // If device not support with locale to get language code then default get first on from the list
                return supportedLocales.first;
              },
              supportedLocales: [
                Locale(AppLang(SupportedLang.arabic).languageCode),
                Locale(AppLang(SupportedLang.english).languageCode),
              ],
            ),
          ),
        );
      },
    );
  }

  String? getInitialScreen() {
    return RouteNames.products;
  }
}
