import 'package:get_it/get_it.dart';
import 'package:holo_challenge/core/config/supported_lang.dart';
import 'package:holo_challenge/modules/cart/cart_bloc.dart';
import 'package:holo_challenge/modules/user/user_preferences_bloc.dart';

GetIt locator = GetIt.I;

void setupLocator(AppLang appLang) {
  locator.registerSingleton<UserPreferencesBloc>(
    // UserPreferencesBloc.initWithLang(appLang),
    UserPreferencesBloc(),
  );

  locator.registerSingleton<CartBloc>(CartBloc());
}
