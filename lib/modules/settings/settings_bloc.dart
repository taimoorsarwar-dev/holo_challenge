import 'package:holo_challenge/core/di/app_locator.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';
import 'package:holo_challenge/modules/base/base_bloc.dart';
import 'package:holo_challenge/modules/user/user_preferences_bloc.dart';
import 'package:rxdart/subjects.dart';

class SettingsBloc extends BlocBase {
  final ReplaySubject<CustomTheme> _selectedThemeController =
      ReplaySubject<CustomTheme>(maxSize: 1);
  Stream<CustomTheme> get selectedTheme => _selectedThemeController.stream;

  SettingsBloc() {
    setTheme(locator<UserPreferencesBloc>().getSelectedTheme());
  }

  @override
  void dispose() {
    _selectedThemeController.close();
    super.dispose();
  }

  void setTheme(CustomTheme theme) {
    if (_selectedThemeController.isClosed == false) {
      _selectedThemeController.sink.add(theme);
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
}
