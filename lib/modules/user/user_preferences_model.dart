import 'package:holo_challenge/core/config/currency_model.dart';
import 'package:holo_challenge/core/config/supported_lang.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';

class UserPreferencesModel {
  UserPreferencesModel();

  int? _id;
  CustomTheme _selectedTheme = CustomTheme.light;
  AppLang _appLang = AppLang(SupportedLang.english);
  CurrencyModel _currency = CurrencyModel(
    id: "1",
    code: "AED",
    label: "Dirham",
    name: "Dirham",
    isDefault: true,
  );
  get isLanguageDirectionLtr => _appLang.isLanguageDirectionLtr;

  CurrencyModel get currency => _currency;

  AppLang get appLang => _appLang;

  CustomTheme get selectedTheme => _selectedTheme;

  int? get id => _id;

  void setId(int id) {
    _id = id;
  }

  void setSelectedTheme(CustomTheme selectedTheme) {
    _selectedTheme = selectedTheme;
  }

  void setCurrency(CurrencyModel currency) {
    _currency = currency;
  }

  void setLanguage(AppLang appLang) {
    _appLang = appLang;
  }

  factory UserPreferencesModel.fromJson(Map<String, dynamic> parsedJson) {
    UserPreferencesModel userPreferences = UserPreferencesModel();

    String selectedThemeStr = parsedJson['selectedTheme'];
    if (selectedThemeStr == CustomTheme.dark.toString()) {
      userPreferences.setSelectedTheme(CustomTheme.dark);
    } else if (selectedThemeStr == CustomTheme.light.toString()) {
      userPreferences.setSelectedTheme(CustomTheme.light);
    } else {
      userPreferences.setSelectedTheme(CustomTheme.dark);
    }
    userPreferences.setLanguage(AppLang.fromString(parsedJson["appLang"]));

    CurrencyModel currencyModel = CurrencyModel.empty();
    currencyModel.fromJson(parsedJson["currency"]);
    userPreferences.setCurrency(currencyModel);

    return userPreferences;
  }

  Map<String, dynamic> toJson() {
    return {
      "selectedTheme": _selectedTheme.toString(),
      "appLang": _appLang.toString(),
      "currency": _currency.toJson(),
    };
  }
}
