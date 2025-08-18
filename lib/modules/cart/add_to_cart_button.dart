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
        double btnSize =
            showCompatButton
                ? UIHelper.chipButtonHeight
                : UIHelper.outlineButtonHeight;

        // Get current quantity from cart
        if (cart != null) {
          List<CartProduct>? products = cart.products;
          if (products != null) {
            for (CartProduct cartProduct in products) {
              if (cartProduct.productModel?.id == model.id) {
                currentQuantity = cartProduct.quantity ?? 0;
                break;
              }
            }
          }
        }

        if (currentQuantity == 0) {
          return _getAddToCartButtonWidget(btnSize: btnSize);
        }
        return _getQuantityWidget(
          currentQuantity: currentQuantity,
          btnSize: btnSize,
        );
      },
    );
  }

  Widget _getAddToCartButtonWidget({required double btnSize}) {
    if (showCompatButton) {
      return CustomIconButton(
        icon: R.assetsImagesIconsAdd,
        buttonIconSize: ButtonIconSize.extraExtraExtraSmall,
        fillColor: ThemePalette.cellBackgroundColor,
        iconColor: ThemePalette.accentColor,
        borderColor: ThemePalette.accentColor,
        showBorder: true,
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

  Widget _getQuantityWidget({int currentQuantity = 0, double? btnSize}) {
    BoxDecoration boxDecoration = BoxDecoration(
      color: ThemePalette.accentColor,
      borderRadius: UIHelper.getBorderRadius(radius: UIHelper.smallRadius),
    );
    Color textColor = ThemePalette.selectedTextColor;

    if (showCompatButton) {
      boxDecoration = BoxDecoration(
        color: ThemePalette.cellBackgroundColor,
        borderRadius: UIHelper.getBorderRadius(radius: UIHelper.smallRadius),
        border: UIHelper.getBorder(color: ThemePalette.accentColor),
      );

      textColor = ThemePalette.primaryText;
    }

    return Container(
      height: btnSize,
      decoration: boxDecoration,
      child: ClipRRect(
        borderRadius: UIHelper.getBorderRadius(radius: UIHelper.smallRadius),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getQuantityButton(
              currentQuantity: currentQuantity,
              btnSize: btnSize,
              btnText: "-",
              textColor: textColor,
              onTap: () {
                cartBloc?.manageCart(
                  productModel: model,
                  quantity: currentQuantity - 1,
                );
              },
            ),
            _getQuantityTextWidget(
              currentQuantity: currentQuantity,
              textColor: textColor,
            ),
            _getQuantityButton(
              currentQuantity: currentQuantity,
              btnSize: btnSize,
              textColor: textColor,
              btnText: "+",
              onTap: () {
                if (currentQuantity >= 3) {
                  CustomToast.show(
                    AppLocalizations.getLocalization().maxQuantityAdded,
                    type: ToastType.generic,
                  );
                } else {
                  cartBloc?.manageCart(
                    productModel: model,
                    quantity: currentQuantity + 1,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getQuantityTextWidget({int currentQuantity = 0, Color? textColor}) {
    return SizedBox(
      width:
          showCompatButton ? UIHelper.tagItemHeight : UIHelper.chipButtonHeight,
      child: Center(
        child: Text(
          currentQuantity.toString(),
          style: AppTextStyle.getLargeTextStyle(
            false,
            textColor ?? ThemePalette.primaryText,
            FontType.bold,
          ),
        ),
      ),
    );
  }

  Widget _getQuantityButton({
    int currentQuantity = 0,
    double? btnSize,
    String? btnText,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return MaterialButton(
      onPressed: onTap,
      minWidth: 0,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: SizedBox(
        width: btnSize,
        child: Center(
          child: Text(
            btnText ?? "",
            style: AppTextStyle.getExtraLargeTextStyle(
              false,
              textColor ?? ThemePalette.primaryText,
              FontType.medium,
            ),
          ),
        ),
      ),
    );
  }
}
