import 'package:flutter/material.dart';
import 'package:holo_challenge/core/theme/app_text_styles.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';
import 'package:holo_challenge/core/theme/ui_helper.dart';
import 'package:holo_challenge/network/product/product_model.dart';
import 'package:holo_challenge/utils/ui_util.dart';
import 'package:holo_challenge/widgets/image/custom_cached_network_image.dart';

class ProductItemCard extends StatelessWidget {
  final ProductModel? productModel;
  final VoidCallback? onTap;
  const ProductItemCard({super.key, this.productModel, this.onTap});

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
            padding: UIHelper.cardPaddingAll,
            child: Row(
              children: [
                _getImageWidget(),
                UIHelper.horizontalSpaceSmall,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel?.title ?? "",
                        style: AppTextStyle.getMediumTextStyle(
                          false,
                          ThemePalette.primaryText,
                          FontType.medium,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('\$${productModel?.price}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _getImageWidget() {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: ThemePalette.backgroundColor,
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
}
