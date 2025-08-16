import 'package:holo_challenge/core/app_router/navigator_service.dart';
import 'package:holo_challenge/core/app_router/route_names.dart';
import 'package:holo_challenge/core/constants/local_storage_keys.dart';
import 'package:holo_challenge/core/localization/app_localization.dart';
import 'package:holo_challenge/modules/base/base_bloc.dart';
import 'package:holo_challenge/modules/products/details/product_details_screen.dart';
import 'package:holo_challenge/network/cart/cart_model.dart';
import 'package:holo_challenge/network/product/product_model.dart';
import 'package:holo_challenge/utils/app_logger.dart';
import 'package:holo_challenge/utils/shared_preferences_utils.dart';
import 'package:holo_challenge/widgets/dialog/confirmation_dialog.dart';
import 'package:rxdart/subjects.dart';

class CartBloc extends BlocBase {
  final ReplaySubject<CartModel?> _cartStreamController =
      ReplaySubject<CartModel?>(maxSize: 1);
  Stream<CartModel?> get cartStream => _cartStreamController.stream;

  final ReplaySubject<int?> _totalCountController = ReplaySubject<int?>(
    maxSize: 1,
  );
  Stream<int?> get totalCount => _totalCountController.stream;

  String? title;
  CartModel? cart;

  static const String _cartKey = LocalStorageKeys.cartKey;
  static const String _cartCountKey = LocalStorageKeys.cartCountKey;

  CartBloc({this.title}) {
    if (title != null && title?.isNotEmpty == true) {
      setTitle(title: title);
    }
    _initCart();
  }

  @override
  void dispose() {
    super.dispose();
    _cartStreamController.close();
    _totalCountController.close();
  }

  CartModel? _getDefaultCartModel() =>
      CartModel(id: cart?.id, userId: cart?.userId);

  Future<void> _initCart() async {
    // Load from SharedPreferences
    final savedCart = await SharedPreferencesUtils.getObject(key: _cartKey);
    if (savedCart != null) {
      try {
        cart = CartModel.fromJson(savedCart);
      } catch (e) {
        AppLogger.log(
          'Error parsing saved cart in _initCart: $e',
          LoggingType.error,
        );
        cart = _getDefaultCartModel();
      }
    } else {
      cart = _getDefaultCartModel();
    }
    setCart(cart);
  }

  void resetCart() {
    cart = _getDefaultCartModel();
    setCart(cart);
  }

  void clearCart() {
    // resetCart();
    // Explicitly clear from storage first and then reset
    SharedPreferencesUtils.saveObject(key: _cartKey, value: null);
    SharedPreferencesUtils.saveInt(key: _cartCountKey, value: 0);

    resetCart();
  }

  void manageCart({ProductModel? productModel, int quantity = 0}) {
    if (productModel == null || cart == null) return;

    bool productExists = false;
    int productIndex = -1;

    // Update existing product if found
    if (cart != null) {
      List<CartProduct>? products = cart?.products;
      if (products != null && products.isNotEmpty) {
        for (int i = 0; i < products.length; i++) {
          if (products[i].productModel?.id == productModel.id) {
            productExists = true;
            productIndex = i;
            break;
          }
        }
      }

      if (productExists) {
        if (quantity > 0) {
          // Update quantity if > 0
          cart?.products?[productIndex].quantity = quantity;
        } else {
          // Remove product if quantity is 0
          cart?.products?.removeAt(productIndex);
        }
        cart?.date = DateTime.now().toUtc().toIso8601String();
      }
    }

    // Add new product if not found and quantity > 0
    if (!productExists && quantity > 0) {
      CartModel? cartModel = cart;

      if (cartModel != null) {
        cartModel.date = DateTime.now().toUtc().toIso8601String();
        cartModel.products ??= [];
        cartModel.products?.add(
          CartProduct(productModel: productModel, quantity: quantity),
        );
      }
    }

    setCart(cart);
  }

  void setCart(CartModel? cart) {
    if (_cartStreamController.isClosed == false) {
      _cartStreamController.sink.add(cart);
    }

    if (!_totalCountController.isClosed) {
      _totalCountController.sink.add(getTotalQuantity(cart));
    }

    _persistCart();
    _persistCartCount();
  }

  int getTotalQuantity(CartModel? cart) {
    int total = 0;

    if (cart != null && cart.products != null) {
      List<CartProduct>? products = cart.products;
      if (products != null && products.isNotEmpty) {
        for (CartProduct product in products) {
          total += product.quantity ?? 0;
        }
      }
    }

    return total;
  }

  Future<void> _persistCart() async {
    if (cart != null) {
      await SharedPreferencesUtils.saveObject(
        key: _cartKey,
        value: cart?.toJson(),
      );
    }
  }

  Future<void> _persistCartCount() async {
    await SharedPreferencesUtils.saveInt(
      key: _cartCountKey,
      value: getTotalQuantity(cart),
    );
  }

  void navigateToProductDetailsScreen({required ProductModel? productModel}) {
    NavigatorService.pushNamed(
      RouteNames.productDetails,
      arguments: ProductDetailsScreenParams(
        -1,
        false,
        productModel: productModel,
      ),
    );
  }

  Future<void> showConfirmationDialog() async {
    NavigatorService.showDialogBox(
      child: ConfirmationDialog(
        title: AppLocalizations.getLocalization().clearYourCart,
        description: AppLocalizations.getLocalization().clearYourCartText,
        positiveBtnText: AppLocalizations.getLocalization().clearCart,
        negativeBtnText: AppLocalizations.getLocalization().cancel,
        positiveIsClicked: () {
          clearCart();
          NavigatorService.pop();
        },
        negativeIsClicked: () {
          NavigatorService.pop();
        },
      ),
    );
  }
}
