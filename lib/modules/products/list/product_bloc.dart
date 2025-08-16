import 'package:holo_challenge/core/app_router/navigator_service.dart';
import 'package:holo_challenge/core/app_router/route_names.dart';
import 'package:holo_challenge/modules/base/base_bloc.dart';
import 'package:holo_challenge/modules/cart/cart_bloc.dart';
import 'package:holo_challenge/modules/cart/cart_screen.dart';
import 'package:holo_challenge/modules/products/details/product_details_screen.dart';
import 'package:holo_challenge/network/product/product_model.dart';
import 'package:holo_challenge/network/product/products_repository.dart';
import 'package:rxdart/subjects.dart';

class ProductBloc extends BlocBase {
  final ReplaySubject<List<ProductModel>> _productsStreamController =
      ReplaySubject<List<ProductModel>>(maxSize: 1);
  Stream<List<ProductModel>> get productsStream =>
      _productsStreamController.stream;

  String? title;

  ProductBloc({this.title}) {
    if (title != null && title!.isNotEmpty) {
      setTitle(title: title);
    }
    fetchProducts(showLoader: true);
  }

  @override
  void dispose() {
    super.dispose();
    _productsStreamController.close();
  }

  void fetchProducts({bool showLoader = false}) async {
    var result = await ProductsRepository.fetchProducts(
      showLoader: showLoader,
      fromJson: ProductModel.fromJson,
    );

    if (result != null) {
      List<ProductModel> list = List.from(result);
      if (_productsStreamController.isClosed == false) {
        _productsStreamController.sink.add(list);
      }
    }
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

  void navigateToCartScreen(CartBloc? cartBloc) {
    NavigatorService.pushNamed(
      RouteNames.cart,
      arguments: CartScreenParams(-1, false, cartBloc: cartBloc),
    );
  }
}
