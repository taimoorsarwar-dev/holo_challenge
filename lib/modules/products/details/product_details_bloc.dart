import 'package:holo_challenge/modules/base/base_bloc.dart';
import 'package:holo_challenge/network/product/product_model.dart';
import 'package:holo_challenge/network/product/products_repository.dart';
import 'package:rxdart/subjects.dart';

class ProductDetailsBloc extends BlocBase {
  final ReplaySubject<ProductModel> _productStreamController =
      ReplaySubject<ProductModel>(maxSize: 1);
  Stream<ProductModel> get productStream => _productStreamController.stream;

  String? title;

  ProductDetailsBloc({this.title, ProductModel? productModel}) {
    if (title != null && title!.isNotEmpty) {
      setTitle(title: title);
    }
    fetchProductById(showLoader: true, id: productModel?.id);
  }

  @override
  void dispose() {
    super.dispose();
    _productStreamController.close();
  }

  void fetchProductById({bool showLoader = false, int? id}) async {
    var result = await ProductsRepository.fetchProductById(
      id: id,
      showLoader: showLoader,
      fromJson: ProductModel.fromJson,
    );

    if (result != null) {
      ProductModel product = result;
      if (_productStreamController.isClosed == false) {
        _productStreamController.sink.add(product);
      }
    }
  }

  // void navigateToProductDetailsScreen() {
  //   NavigatorService.pushNamed(
  //     RouteNames.productDetails,
  //     arguments: ProductDetailsScreenParams(-1, false),
  //   );
  // }
}
