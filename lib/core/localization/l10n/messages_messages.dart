// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.
// @dart=2.12
// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(
    String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'messages';

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'addToCart': MessageLookupByLibrary.simpleMessage('Add To Cart'),
    'aed': MessageLookupByLibrary.simpleMessage('AED'),
    'arabic': MessageLookupByLibrary.simpleMessage('Arabic'),
    'cancel': MessageLookupByLibrary.simpleMessage('Cancel'),
    'cartTotal': MessageLookupByLibrary.simpleMessage('Cart Total'),
    'checkoutNow': MessageLookupByLibrary.simpleMessage('Checkout now'),
    'clearCart': MessageLookupByLibrary.simpleMessage('Clear Cart'),
    'clearYourCart': MessageLookupByLibrary.simpleMessage('Clear your cart?'),
    'clearYourCartText': MessageLookupByLibrary.simpleMessage('All items in your cart will be removed. This action cannot be undone.'),
    'dark': MessageLookupByLibrary.simpleMessage('Dark'),
    'darkTheme': MessageLookupByLibrary.simpleMessage('Dark theme?'),
    'deliveryFee': MessageLookupByLibrary.simpleMessage('Delivery Fee'),
    'emptyCartText': MessageLookupByLibrary.simpleMessage('Let\'s fill it up with something special'),
    'emptyCartTitle': MessageLookupByLibrary.simpleMessage('Oh no, it\'s empty in here!'),
    'english': MessageLookupByLibrary.simpleMessage('English'),
    'items': MessageLookupByLibrary.simpleMessage('Items'),
    'language': MessageLookupByLibrary.simpleMessage('Language'),
    'light': MessageLookupByLibrary.simpleMessage('Light'),
    'maxQuantityAdded': MessageLookupByLibrary.simpleMessage('Max quantity added'),
    'noInternetConnection': MessageLookupByLibrary.simpleMessage('No internet connection. Please check your network and try again.'),
    'paymentSummary': MessageLookupByLibrary.simpleMessage('Payment Summary'),
    'preferences': MessageLookupByLibrary.simpleMessage('Preferences'),
    'products': MessageLookupByLibrary.simpleMessage('Products'),
    'reviews': MessageLookupByLibrary.simpleMessage('Reviews'),
    'serverTakingLongRespond': MessageLookupByLibrary.simpleMessage('The server is taking too long to respond. Please try again later.'),
    'settings': MessageLookupByLibrary.simpleMessage('Settings'),
    'shoppingCart': MessageLookupByLibrary.simpleMessage('Your Cart'),
    'somethingWentWrong': MessageLookupByLibrary.simpleMessage('Something went wrong! Please try after sometime.'),
    'startShopping': MessageLookupByLibrary.simpleMessage('Start Shopping'),
    'subTotal': MessageLookupByLibrary.simpleMessage('Subtotal'),
    'totalItems': MessageLookupByLibrary.simpleMessage('Total items')
  };
}
