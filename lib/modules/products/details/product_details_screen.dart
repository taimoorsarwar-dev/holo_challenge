import 'package:flutter/material.dart';
import 'package:holo_challenge/core/app_router/navigator_service.dart';
import 'package:holo_challenge/core/di/app_locator.dart';
import 'package:holo_challenge/core/theme/ui_theme.dart';
import 'package:holo_challenge/modules/base/base_bloc.dart';
import 'package:holo_challenge/modules/base/base_state.dart';
import 'package:holo_challenge/modules/cart/add_to_cart_button.dart';
import 'package:holo_challenge/modules/cart/cart_bloc.dart';
import 'package:holo_challenge/network/product/product_model.dart';
import 'package:holo_challenge/r.dart';
import 'package:holo_challenge/utils/currency_utils.dart';
import 'package:holo_challenge/utils/ui_util.dart';
import 'package:holo_challenge/widgets/buttons/custom_icon_button.dart';
import 'package:holo_challenge/widgets/image/custom_cached_network_image.dart';
import 'package:holo_challenge/widgets/rating/star_rating.dart';

import 'product_details_bloc.dart';

class ProductDetailsScreenParams {
  final int tabIndex;
  final bool isLaunchedInTab;
  final ProductModel? productModel;

  ProductDetailsScreenParams(
    this.tabIndex,
    this.isLaunchedInTab, {
    this.productModel,
  });
}

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, this.params});
  final ProductDetailsScreenParams? params;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends BaseState<ProductDetailsScreen>
    with TickerProviderStateMixin {
  ProductDetailsBloc? _productBloc;
  late CartBloc? _cartBloc;

  @override
  void initState() {
    super.initState();

    _cartBloc = locator<CartBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createBloc();
  }

  bool createBloc() {
    _productBloc ??= ProductDetailsBloc(
      productModel: widget.params?.productModel,
    );

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
      body: BlocProvider<ProductDetailsBloc>(
        bloc: _productBloc,
        child: Stack(children: <Widget>[_getBaseContainer()]),
      ),
      backgroundColor: ThemePalette.backgroundColor,
    );
  }

  Widget _getBaseContainer() {
    return StreamBuilder<Object>(
      stream: _productBloc?.productStream,
      builder: (context, snapshot) {
        ProductModel? productModel;
        if (snapshot.hasData && snapshot.data is ProductModel) {
          productModel = snapshot.data as ProductModel;
        }
        return SafeArea(
          child: Column(
            children: [
              getAppBarWidget(
                backgroundColor: ThemePalette.backgroundColor,
                leadingWidget: getCustomBackButton(
                  icon: R.assetsImagesIconsArrowLeft,
                  needLeftMargin: true,
                  onPressed: () => backIsPressed(),
                ),
              ),
              Expanded(child: _getBody(productModel: productModel)),
              Container(
                padding: EdgeInsets.fromLTRB(
                  UIHelper.mediumPadding,
                  UIHelper.mediumPadding,
                  UIHelper.mediumPadding,
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getPriceWidget(
                      model: productModel,
                      removeBottomPadding: true,
                    ),
                    _getAddToCartButton(model: productModel),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getBody({ProductModel? productModel}) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getImages(productModel: productModel),
          _getDetailsWidget(productModel: productModel),
        ],
      ),
    );
  }

  Widget _getDetailsWidget({ProductModel? productModel}) {
    return Container(
      color: ThemePalette.whiteColor,

      padding: const EdgeInsets.all(UIHelper.largePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getCategoryWidget(model: productModel),
          _getPriceWidget(model: productModel),
          _getRatingWidget(model: productModel),
          _getTitleWidget(model: productModel),
          _getDescriptionWidget(model: productModel),
        ],
      ),
    );
  }

  Widget _getImages({ProductModel? productModel}) {
    return Container(
      color: ThemePalette.backgroundColor,

      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          productModel != null && productModel.image?.isNotEmpty == true
              ? _getImagesSliderWidget(image: productModel.image)
              : listingImagePlaceholder(),
        ],
      ),
    );
  }

  Widget _getImagesSliderWidget({required String? image}) {
    return Container(
      padding: EdgeInsets.all(UIHelper.largePadding),
      height: UIHelper.imageHeight + MediaQuery.of(context).padding.top,
      child: CustomCachedNetworkImage(
        image ?? "",
        bgColor: ThemePalette.backgroundColor,
        boxFit: BoxFit.contain,
      ),
    );
  }

  static Widget listingImagePlaceholder({Color? iconColor}) {
    return Container(
      width: double.infinity,
      height:
          UIHelper.imageHeight +
          MediaQuery.of(NavigatorService.currentContext).padding.top,
      padding: EdgeInsets.only(
        top: MediaQuery.of(NavigatorService.currentContext).padding.top,
      ),
      color: ThemePalette.galleryBgColor,
      child: Center(
        child: Image.asset(
          R.assetsImagesIconsGallery,
          color: iconColor ?? ThemePalette.iconsColor,
          height: 40,
        ),
      ),
    );
  }

  Widget getCustomBackButton({
    required String icon,
    required VoidCallback onPressed,
    bool needLeftMargin = false,
  }) {
    return Container(
      margin: EdgeInsets.only(right: UIHelper.mediumPadding),
      child: CustomIconButton(
        icon: icon,
        isCircular: true,
        onTap: onPressed,
        size: UIHelper.ctaButtonSize,
      ),
    );
  }

  Widget _getCategoryWidget({required ProductModel? model}) {
    String? category = model?.category?.trim();
    if (category != null && category.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(bottom: UIHelper.mediumPadding),
        child: UiUtils.getChipItemCell(
          label: category.capitalizeFirstOfEach,
          bgColor: ThemePalette.backgroundColor,
        ),
      );
    }

    return const SizedBox();
  }

  Widget _getRatingWidget({required ProductModel? model}) {
    String? category = model?.rating?.rate?.toString();
    String? totalCount = model?.rating?.count?.toString();
    if (category != null && category.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(bottom: UIHelper.mediumPadding),
        child: Row(
          children: [
            _starRatingWidget(rating: double.parse(category)),
            if (totalCount != null && totalCount.isNotEmpty)
              Text(
                "($totalCount Reviews)",
                style: AppTextStyle.getMediumTextStyle(
                  false,
                  ThemePalette.secondaryText,
                  FontType.regular,
                ),
              ),
          ],
        ),
      );
    }

    return const SizedBox();
  }

  Widget _starRatingWidget({double rating = 0}) {
    return StarRating(rating: rating, starCount: 5);
  }

  Widget _getPriceWidget({
    required ProductModel? model,
    bool removeBottomPadding = false,
  }) {
    String? price = CurrencyUtils.getValueWithCurrency(model?.price);
    if (price != null && price.isNotEmpty) {
      return Container(
        margin:
            removeBottomPadding
                ? EdgeInsets.zero
                : EdgeInsets.only(bottom: UIHelper.mediumPadding),
        child: Text(
          price,
          style: AppTextStyle.getExtraLargeTextStyle(
            false,
            ThemePalette.accentColor,
            FontType.bold,
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Widget _getTitleWidget({required ProductModel? model}) {
    String? title = model?.title?.trim();
    if (title != null && title.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(bottom: UIHelper.mediumPadding),
        child: Text(
          title,
          style: AppTextStyle.getLargeTextStyle(
            false,
            ThemePalette.primaryText,
            FontType.bold,
            lineHeight: 1.5,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return const SizedBox();
  }

  Widget _getDescriptionWidget({required ProductModel? model}) {
    String? description = model?.description?.trim();
    if (description != null && description.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(bottom: UIHelper.mediumPadding),
        child: Text(
          description,
          style: AppTextStyle.getMediumTextStyle(
            false,
            ThemePalette.primaryText,
            FontType.regular,
            lineHeight: 1.4,
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Widget _getAddToCartButton({required ProductModel? model}) {
    if (model != null) {
      return AddToCartButton(cartBloc: _cartBloc, model: model);
    }

    return const SizedBox();
  }
}
