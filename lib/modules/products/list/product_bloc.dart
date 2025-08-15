import 'package:holo_challenge/modules/base/base_bloc.dart';
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

  void navigateToProductDetailsScreen({required ProductModel? productModel}) {}
}
