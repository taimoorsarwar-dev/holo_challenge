import 'package:holo_challenge/core/app_router/navigator_service.dart';
import 'package:holo_challenge/core/app_router/route_names.dart';
import 'package:holo_challenge/core/localization/app_localization.dart';
import 'package:holo_challenge/modules/base/base_bloc.dart';
import 'package:holo_challenge/modules/products/details/product_details_screen.dart';
import 'package:holo_challenge/network/cart/cart_model.dart';
import 'package:holo_challenge/network/product/product_model.dart';
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

  CartBloc({this.title}) {
    if (title != null && title!.isNotEmpty) {
      setTitle(title: title);
    }
    defaultCart();
  }

  @override
  void dispose() {
    super.dispose();
    _cartStreamController.close();
    _totalCountController.close();
  }

  void defaultCart() {
    cart = CartModel(id: cart?.id, userId: cart?.userId);
    setCart(cart);
    setCartCount(cart);
  }

  void clearCart() {
    defaultCart();
  }

  void manageCart({ProductModel? productModel, int quantity = 0}) {
    if (productModel == null) return;

    bool productExists = false;

    // Update existing product if found
    if (cart != null) {
      List<CartProduct>? products = cart?.products;
      if (products != null && products.isNotEmpty) {
        for (CartProduct cartProduct in products) {
          if (cartProduct.productModel?.id == productModel.id) {
            //set the quantity directly
            cartProduct.quantity = quantity;
            productExists = true;
            break;
          }
        }
      }

      if (productExists) {
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
    setCartCount(cart);
  }

  void setCart(CartModel? cart) {
    if (_cartStreamController.isClosed == false) {
      _cartStreamController.sink.add(cart);
    }
  }

  void setCartCount(CartModel? cart) {
    if (!_totalCountController.isClosed) {
      _totalCountController.sink.add(getTotalQuantity(cart));
    }
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
