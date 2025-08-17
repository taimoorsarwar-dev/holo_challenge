import 'package:flutter/material.dart';
import 'package:holo_challenge/core/di/app_locator.dart';
import 'package:holo_challenge/core/theme/app_responsive.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';
import 'package:holo_challenge/core/theme/ui_helper.dart';
import 'package:holo_challenge/modules/base/base_bloc.dart';
import 'package:holo_challenge/modules/base/base_state.dart';
import 'package:holo_challenge/modules/cart/cart_bloc.dart';
import 'package:holo_challenge/modules/products/list/product_item_card.dart';
import 'package:holo_challenge/network/product/product_model.dart';
import 'package:holo_challenge/r.dart';
import 'package:holo_challenge/widgets/avatar/avatar.dart';
import 'package:holo_challenge/widgets/buttons/custom_icon_button.dart';

import 'product_bloc.dart';

class ProductsScreenParams {
  final int tabIndex;
  final bool isLaunchedInTab;

  ProductsScreenParams(this.tabIndex, this.isLaunchedInTab);
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, this.params});
  final ProductsScreenParams? params;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends BaseState<ProductsScreen>
    with TickerProviderStateMixin {
  ProductBloc? _productBloc;
  CartBloc? _cartBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createBloc();
  }

  bool createBloc() {
    _productBloc ??= ProductBloc(title: "Products");
    _cartBloc ??= locator<CartBloc>();
    return false;
  }

  @override
  void dispose() {
    super.dispose();
    _productBloc?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryDate = MediaQuery.of(context);
    AppResponsive.isSmallDevice(mediaQueryDate);
    AppResponsive.isTablet(mediaQueryDate);

    if (_productBloc == null) {
      return Container();
    }

    return Scaffold(
      body: BlocProvider<ProductBloc>(
        bloc: _productBloc,
        child: Stack(children: <Widget>[_getBaseContainer()]),
      ),
      backgroundColor: ThemePalette.backgroundColor,
    );
  }

  Widget _getBaseContainer() {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          getAppBarWidget(
            titleStream: _productBloc?.titleStream,
            isBackNeeded: widget.params?.isLaunchedInTab == false,
            leadingWidget: AvatarWidget(
              onProfileClick: () {
                _productBloc?.navigateToSettingsScreen();
              },
              isCircular: true,
            ),
            suffixWidgets: [
              StreamBuilder(
                stream: locator<CartBloc>().totalCount,
                builder: (context, asyncSnapshot) {
                  int? count;
                  if (asyncSnapshot.hasData && asyncSnapshot.data is int) {
                    count = asyncSnapshot.data as int;
                  }
                  return CustomIconButton(
                    icon: R.assetsImagesIconsCart,
                    isCircular: true,
                    count: count,
                    onTap: () {
                      _productBloc?.navigateToCartScreen(_cartBloc);
                    },
                    size: UIHelper.appBarButtonHeight,
                  );
                },
              ),
            ],
          ),
          _getBody(),
        ],
      ),
    );
  }

  Widget _getBody() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          UIHelper.largePadding,
          0,
          UIHelper.largePadding,
          UIHelper.largePadding,
        ),
        decoration: BoxDecoration(color: ThemePalette.backgroundColor),
        child: StreamBuilder<Object>(
          stream: _productBloc?.productsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data is List<ProductModel>) {
              List<ProductModel>? list = snapshot.data as List<ProductModel>?;
              if (list != null && list.isNotEmpty) {
                return _getProductsListWidget(list);
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _getProductsListWidget(List<ProductModel>? list) {
    if (list != null && list.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: list.length,

        itemBuilder: (BuildContext context, int index) {
          return _getProductItemCard(list[index]);
        },
      );
    }
    return const SizedBox();
  }

  Widget _getProductItemCard(ProductModel? model) {
    if (model != null) {
      return ProductItemCard(
        productModel: model,
        cartBloc: _cartBloc,
        onTap: () {
          _productBloc?.navigateToProductDetailsScreen(productModel: model);
        },
      );
    }
    return const SizedBox();
  }
}
