import 'package:holo_challenge/core/config/currency_model.dart';
import 'package:holo_challenge/core/di/app_locator.dart';
import 'package:holo_challenge/core/localization/app_localization.dart';
import 'package:holo_challenge/modules/user/user_preferences_bloc.dart';
import 'package:intl/intl.dart';

class CurrencyUtils {
  static String? getValueWithCurrency(num? value) {
    if (value != null) {
      CurrencyModel currency =
          locator<UserPreferencesBloc>().getSelectedCurrency();

      // final formatter = NumberFormat("###,###");

      final hasDecimals = value % 1 != 0;

      // Use different formats based on whether the number has decimals
      final formatter =
          hasDecimals
              ? NumberFormat("#,##0.##") // Supports up to 2 decimal places
              : NumberFormat("#,##0");

      // return "${currency.displayName()!} ${formatter.format(value)}";
      return "${AppLocalizations.getLocalization().aed} ${formatter.format(value)}";
    }

    return null;
  }
}
