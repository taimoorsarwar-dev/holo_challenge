import 'package:equatable/equatable.dart';
import 'package:holo_challenge/core/localization/app_localization.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';

abstract class DisplayNameProvider {
  String? getDisplayName();
}

class AppTheme extends Equatable implements DisplayNameProvider {
  static AppTheme fromString(String option) {
    if (option == CustomTheme.dark.toString()) {
      return const AppTheme(CustomTheme.dark);
    } else if (option == CustomTheme.light.toString()) {
      return const AppTheme(CustomTheme.light);
    }
    return const AppTheme(CustomTheme.light);
  }

  final CustomTheme _selectedTheme;

  const AppTheme(this._selectedTheme);

  get displayValue {
    if (_selectedTheme == CustomTheme.dark) {
      return AppLocalizations.getLocalization().dark;
    } else if (_selectedTheme == CustomTheme.light) {
      return AppLocalizations.getLocalization().light;
    }
  }

  @override
  String toString() {
    return _selectedTheme.toString();
  }

  @override
  String getDisplayName() {
    return displayValue;
  }

  @override
  List<Object> get props => [_selectedTheme];
}
