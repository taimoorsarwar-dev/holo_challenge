import 'package:flutter/material.dart';
import 'package:holo_challenge/core/theme/app_text_styles.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';
import 'package:holo_challenge/core/theme/ui_helper.dart';
import 'package:holo_challenge/modules/cart/add_to_cart_button.dart';
import 'package:holo_challenge/modules/cart/cart_bloc.dart';
import 'package:holo_challenge/network/product/product_model.dart';
import 'package:holo_challenge/utils/currency_utils.dart';
import 'package:holo_challenge/utils/ui_util.dart';
import 'package:holo_challenge/widgets/image/custom_cached_network_image.dart';

class ProductItemCard extends StatelessWidget {
  final ProductModel? productModel;
  final VoidCallback? onTap;
  final CartBloc? cartBloc;
  const ProductItemCard({
    super.key,
    this.productModel,
    this.onTap,
    this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    if (productModel != null) {
      return Container(
        decoration: UiUtils.getBoxDecorationForCardsWithShadow(),
        margin: const EdgeInsets.only(bottom: UIHelper.smallPadding),
        child: ClipRRect(
          borderRadius: UIHelper.cardBorderRadiusAll,
          child: MaterialButton(
            onPressed: onTap,
            minWidth: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.zero,

            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    _getImageWidget(size: 125),
                    if (cartBloc != null)
                      Padding(
                        padding: EdgeInsets.all(UIHelper.extraSmallPadding),
                        child: AddToCartButton(
                          cartBloc: cartBloc,
                          model: productModel!,
                          showCompatButton: true,
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    // _getImageWidget(),
                    // UIHelper.horizontalSpaceSmall,
                    Expanded(
                      child: Padding(
                        padding: UIHelper.cardPaddingAll,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getPriceWidget(model: productModel),
                            _getTitleWidget(model: productModel),
                            // if (cartBloc != null)
                            //   AddToCartButton(
                            //     cartBloc: cartBloc,
                            //     model: productModel!,
                            //     showCompatButton: true,
                            //   ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _getImageWidget({double? size = 75}) {
    return Container(
      // width: size,
      height: size,
      decoration: BoxDecoration(
        color: ThemePalette.dividerColor,
        // borderRadius: UIHelper.cardBorderRadiusAll,
      ),
      padding: EdgeInsets.all(UIHelper.extraSmallPadding),
      child: CustomCachedNetworkImage(
        productModel?.image ?? "",
        bgColor: ThemePalette.backgroundColor,
        boxFit: BoxFit.contain,
      ),
    );
  }

  Widget _getPriceWidget({required ProductModel? model}) {
    String? price = CurrencyUtils.getValueWithCurrency(model?.price);
    if (price != null && price.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(bottom: UIHelper.smallPadding),
        child: Text(
          price,
          style: AppTextStyle.getLargeTextStyle(
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
      return Text(
        title,
        style: AppTextStyle.getMediumTextStyle(
          false,
          ThemePalette.primaryText,
          FontType.medium,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }

    return const SizedBox();
  }
}
