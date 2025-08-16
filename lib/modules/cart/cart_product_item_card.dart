import 'package:flutter/material.dart';
import 'package:holo_challenge/core/theme/app_text_styles.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';
import 'package:holo_challenge/core/theme/ui_helper.dart';
import 'package:holo_challenge/modules/cart/cart_bloc.dart';
import 'package:holo_challenge/network/cart/cart_model.dart';
import 'package:holo_challenge/network/product/product_model.dart';
import 'package:holo_challenge/utils/currency_utils.dart';
import 'package:holo_challenge/widgets/image/custom_cached_network_image.dart';

import 'add_to_cart_button.dart';

class CartProductItemCard extends StatelessWidget {
  final CartProduct? cartProduct;
  final VoidCallback? onTap;
  final CartBloc? cartBloc;
  const CartProductItemCard({
    super.key,
    this.cartProduct,
    this.onTap,
    this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    if (cartProduct != null) {
      ProductModel? productModel = cartProduct?.productModel;
      return MaterialButton(
        onPressed: onTap,
        minWidth: 0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: UIHelper.cardPaddingAll,
        child: IntrinsicHeight(
          child: Row(
            children: [
              _getImageWidget(productModel: productModel),
              UIHelper.horizontalSpaceSmall,
              Expanded(
                child: _getProductDetailsWidget(productModel: productModel),
              ),
              UIHelper.horizontalSpaceSmall,
              _getQuantityWidget(productModel: productModel),
            ],
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _getImageWidget({double? size = 75, ProductModel? productModel}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: ThemePalette.dividerColor,
        borderRadius: UIHelper.cardBorderRadiusAll,
      ),
      padding: EdgeInsets.all(UIHelper.extraSmallPadding),
      child: CustomCachedNetworkImage(
        productModel?.image ?? "",
        bgColor: ThemePalette.backgroundColor,
        boxFit: BoxFit.contain,
      ),
    );
  }

  Widget _getProductDetailsWidget({ProductModel? productModel}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getPriceWidget(model: productModel),
        _getTitleWidget(model: productModel),
      ],
    );
  }

  Widget _getPriceWidget({required ProductModel? model}) {
    String? price = CurrencyUtils.getValueWithCurrency(model?.price);
    if (price != null && price.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(bottom: UIHelper.smallPadding),
        child: Text(
          price,
          style: AppTextStyle.getMediumTextStyle(
            false,
            ThemePalette.primaryText,
            FontType.medium,
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Widget _getTitleWidget({required ProductModel? model}) {
    String? title = model?.title?.trim();
    if (title != null && title.isNotEmpty) {
      return Text(
        title,
        style: AppTextStyle.getSmallTextStyle(
          false,
          ThemePalette.primaryText,
          FontType.regular,
          lineHeight: 1.5,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }

    return const SizedBox();
  }

  Widget _getQuantityWidget({ProductModel? productModel}) {
    if (cartBloc != null && productModel != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AddToCartButton(
            cartBloc: cartBloc,
            model: productModel,
            showCompatButton: true,
          ),
          _getTotalPriceWidget(model: cartProduct),
        ],
      );
    }
    return const SizedBox();
  }

  Widget _getTotalPriceWidget({required CartProduct? model}) {
    num? price = model?.productModel?.price;
    if (price != null) {
      int quantity = model?.quantity ?? 0;
      if (quantity > 0) {
        num totalPrice = price * quantity;
        String? finalPrice = CurrencyUtils.getValueWithCurrency(totalPrice);
        if (finalPrice != null && finalPrice.isNotEmpty) {
          return Container(
            margin: EdgeInsets.only(bottom: UIHelper.smallPadding),
            child: Text(
              finalPrice,
              style: AppTextStyle.getMediumTextStyle(
                false,
                ThemePalette.accentColor,
                FontType.bold,
              ),
            ),
          );
        }
      }
    }

    return const SizedBox();
  }
}
