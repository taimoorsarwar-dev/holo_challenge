import 'package:get_it/get_it.dart';
import 'package:holo_challenge/core/config/supported_lang.dart';
import 'package:holo_challenge/modules/cart/cart_bloc.dart';

GetIt locator = GetIt.I;

void setupLocator(AppLang appLang) {
  locator.registerSingleton<CartBloc>(CartBloc());
}
