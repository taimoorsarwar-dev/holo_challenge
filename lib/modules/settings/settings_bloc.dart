import 'package:holo_challenge/core/config/supported_lang.dart';
import 'package:holo_challenge/core/di/app_locator.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';
import 'package:holo_challenge/modules/base/base_bloc.dart';
import 'package:holo_challenge/modules/user/user_preferences_bloc.dart';
import 'package:rxdart/subjects.dart';

class SettingsBloc extends BlocBase {
  final ReplaySubject<CustomTheme> _selectedThemeController =
      ReplaySubject<CustomTheme>(maxSize: 1);
  Stream<CustomTheme> get selectedTheme => _selectedThemeController.stream;

  final ReplaySubject<AppLang> _selectedLanguageController =
      ReplaySubject<AppLang>(maxSize: 1);
  Stream<AppLang> get selectedLanguage => _selectedLanguageController.stream;

  SettingsBloc() {
    setTheme(locator<UserPreferencesBloc>().getSelectedTheme());
    setLanguage(locator<UserPreferencesBloc>().getSelectedLanguage());
  }

  @override
  void dispose() {
    _selectedThemeController.close();
    _selectedLanguageController.close();
    super.dispose();
  }

  void setTheme(CustomTheme theme) {
    if (_selectedThemeController.isClosed == false) {
      _selectedThemeController.sink.add(theme);
    }
  }

  void setLanguage(AppLang appLang) {
    if (_selectedLanguageController.isClosed == false) {
      _selectedLanguageController.sink.add(appLang);
    }
  }

  void manageTheme({bool isDarkTheme = false}) {
    if (isDarkTheme) {
      setTheme(CustomTheme.dark);
      locator<UserPreferencesBloc>().setSelectedTheme(CustomTheme.dark);
    } else {
      setTheme(CustomTheme.light);
      locator<UserPreferencesBloc>().setSelectedTheme(CustomTheme.light);
    }

    locator<UserPreferencesBloc>().setPreferences();
  }

  void manageLanguage({bool isArabic = false}) {
    if (isArabic) {
      setLanguage(AppLang(SupportedLang.arabic));
      locator<UserPreferencesBloc>().setSelectedLanguage(
        AppLang(SupportedLang.arabic),
      );
    } else {
      setLanguage(AppLang(SupportedLang.english));
      locator<UserPreferencesBloc>().setSelectedLanguage(
        AppLang(SupportedLang.english),
      );
    }

    locator<UserPreferencesBloc>().setPreferences();
  }
}
