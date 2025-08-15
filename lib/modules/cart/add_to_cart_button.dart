import 'package:flutter/material.dart';
import 'package:holo_challenge/core/localization/app_localization.dart';
import 'package:holo_challenge/core/theme/ui_theme.dart';
import 'package:holo_challenge/modules/cart/cart_bloc.dart';
import 'package:holo_challenge/network/cart/cart_model.dart';
import 'package:holo_challenge/network/product/product_model.dart';
import 'package:holo_challenge/r.dart';
import 'package:holo_challenge/widgets/buttons/custom_icon_button.dart';
import 'package:holo_challenge/widgets/buttons/primary_button.dart';
import 'package:holo_challenge/widgets/image/multi_source_image.dart';
import 'package:holo_challenge/widgets/loader/custom_toast.dart';

class AddToCartButton extends StatelessWidget {
  final CartBloc? cartBloc;
  final ProductModel model;
  final bool showCompatButton;
  const AddToCartButton({
    super.key,
    this.cartBloc,
    required this.model,
    this.showCompatButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CartModel?>(
      stream: cartBloc?.cartStream,
      builder: (context, snapshot) {
        int currentQuantity = 0;
        CartModel? cart = snapshot.data;

        double btnSize = UIHelper.outlineButtonHeight;

        if (showCompatButton) {
          btnSize = UIHelper.chipButtonHeight;
        }

        // Get current quantity from cart
        if (cart != null) {
          List<CartProduct>? products = cart.products;
          if (products != null) {
            for (var product in products) {
              if (product.productId == model.id) {
                currentQuantity = product.quantity ?? 0;
                break;
              }
            }
          }
        }

        if (currentQuantity == 0) {
          if (showCompatButton) {
            return CustomIconButton(
              icon: R.assetsImagesIconsAdd,
              buttonIconSize: ButtonIconSize.extraExtraExtraSmall,
              fillColor: ThemePalette.accentColor,
              iconColor: ThemePalette.selectedTextColor,
              isCircular: true,
              onTap: () {
                cartBloc?.manageCart(productModel: model, quantity: 1);
              },
              size: btnSize,
            );
          }
          return PrimaryButton(
            title: AppLocalizations.getLocalization().addToCart,
            onTap: () {
              cartBloc?.manageCart(productModel: model, quantity: 1);
            },
            padding: EdgeInsets.symmetric(horizontal: UIHelper.smallPadding),
            textStyle: AppTextStyle.getMediumTextStyle(
              false,
              ThemePalette.selectedTextColor,
              FontType.bold,
            ),
            height: btnSize,
          );
        }

        if (showCompatButton) {}

        return Container(
          height: btnSize,
          decoration: BoxDecoration(
            color: ThemePalette.accentColor,
            borderRadius: UIHelper.getBorderRadius(
              radius: UIHelper.smallRadius,
            ),
          ),
          child: ClipRRect(
            borderRadius: UIHelper.getBorderRadius(
              radius: UIHelper.smallRadius,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  onPressed: () {
                    cartBloc?.manageCart(
                      productModel: model,
                      quantity: currentQuantity - 1,
                    );
                  },
                  minWidth: 0,
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: SizedBox(
                    width: btnSize,
                    child: Center(
                      child: Text(
                        "-",
                        style: AppTextStyle.getExtraLargeTextStyle(
                          false,
                          ThemePalette.selectedTextColor,
                          FontType.medium,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width:
                      showCompatButton
                          ? UIHelper.tagItemHeight
                          : UIHelper.chipButtonHeight,
                  child: Center(
                    child: Text(
                      currentQuantity.toString(),
                      style: AppTextStyle.getLargeTextStyle(
                        false,
                        ThemePalette.selectedTextColor,
                        FontType.bold,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    if (currentQuantity >= 3) {
                      CustomToast.show(
                        "Max quantity added",
                        type: ToastType.generic,
                      );
                    } else {
                      cartBloc?.manageCart(
                        productModel: model,
                        quantity: currentQuantity + 1,
                      );
                    }
                  },
                  minWidth: 0,
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: SizedBox(
                    width: btnSize,
                    child: Center(
                      child: Text(
                        "+",
                        style: AppTextStyle.getExtraLargeTextStyle(
                          false,
                          ThemePalette.selectedTextColor,
                          FontType.medium,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return const SizedBox();
  }
}
