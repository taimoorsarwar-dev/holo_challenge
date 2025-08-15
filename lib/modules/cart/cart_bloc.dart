import 'package:holo_challenge/modules/base/base_bloc.dart';
import 'package:holo_challenge/network/cart/cart_model.dart';
import 'package:holo_challenge/network/product/product_model.dart';
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
    cart = CartModel(id: 1, userId: 1);
    if (_cartStreamController.isClosed == false) {
      _cartStreamController.sink.add(cart);
    }
    getTotalQuantity(cart);
    // fetchProducts(showLoader: true);
  }

  @override
  void dispose() {
    super.dispose();
    _cartStreamController.close();
    _totalCountController.close();
  }

  void manageCart({ProductModel? productModel, int quantity = 0}) {
    if (productModel == null) return;

    bool productExists = false;

    // Update existing product if found
    if (cart != null) {
      List<CartProduct>? products = cart?.products;
      if (products != null && products.isNotEmpty) {
        for (CartProduct product in products) {
          if (product.productId == productModel.id) {
            //set the quantity directly
            product.quantity = quantity;
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
          CartProduct(productId: productModel.id, quantity: quantity),
        );
      }
    }

    if (_cartStreamController.isClosed == false) {
      _cartStreamController.sink.add(cart);
    }

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
}
