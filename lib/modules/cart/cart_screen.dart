import 'package:flutter/material.dart';
import 'package:holo_challenge/core/localization/app_localization.dart';
import 'package:holo_challenge/core/theme/ui_theme.dart';
import 'package:holo_challenge/modules/base/base_state.dart';
import 'package:holo_challenge/modules/cart/cart_bloc.dart';
import 'package:holo_challenge/network/cart/cart_model.dart';
import 'package:holo_challenge/r.dart';
import 'package:holo_challenge/utils/currency_utils.dart';
import 'package:holo_challenge/utils/ui_util.dart';
import 'package:holo_challenge/widgets/buttons/custom_icon_button.dart';
import 'package:holo_challenge/widgets/buttons/primary_button.dart';

import 'cart_product_item_card.dart';

class CartScreenParams {
  final CartBloc? cartBloc;
  final int tabIndex;
  final bool isLaunchedInTab;

  CartScreenParams(
    this.tabIndex,
    this.isLaunchedInTab, {
    required this.cartBloc,
  });
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.params});
  final CartScreenParams? params;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends BaseState<CartScreen>
    with TickerProviderStateMixin {
  late CartBloc? _cartBloc;
  num cartTotal = 0;

  @override
  void initState() {
    super.initState();

    _cartBloc = widget.params?.cartBloc;
    _cartBloc?.setTitle(title: AppLocalizations.getLocalization().shoppingCart);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryDate = MediaQuery.of(context);
    AppResponsive.isSmallDevice(mediaQueryDate);
    AppResponsive.isTablet(mediaQueryDate);

    if (_cartBloc == null) {
      return Container();
    }

    return Scaffold(
      body: _getBaseContainer(),
      backgroundColor: ThemePalette.backgroundColor,
    );
  }

  Widget _getBaseContainer() {
    return SafeArea(
      child: Column(
        children: [
          getAppBarWidget(
            titleStream: _cartBloc?.titleStream,
            isBackNeeded: widget.params?.isLaunchedInTab == false,
            suffixWidgets: [
              CustomIconButton(
                icon: R.assetsImagesIconsDelete,
                isCircular: true,
                onTap: () {
                  _cartBloc?.showConfirmationDialog();
                },
                size: UIHelper.appBarButtonHeight,
              ),
            ],
          ),
          _getBody(),
        ],
      ),
    );
  }

  Widget _getBody() {
    return StreamBuilder<Object?>(
      stream: _cartBloc?.cartStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data is CartModel) {
          CartModel? cartModel = snapshot.data as CartModel?;
          List<CartProduct> cartItems = cartModel?.products ?? [];
          if (cartItems.isNotEmpty) {
            return Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(UIHelper.mediumPadding),
                        child: Column(
                          children: [
                            _getProductsListWidget(cartItems),
                            UIHelper.verticalSpaceMedium,
                            _getPaymentSummaryWidget(cartItems),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      UIHelper.mediumPadding,
                      UIHelper.mediumPadding,
                      UIHelper.mediumPadding,
                      0,
                    ),
                    child: _getCheckoutButton(),
                  ),
                ],
              ),
            );
          }
        }
        return const SizedBox();
      },
    );
  }

  Widget _getProductsListWidget(List<CartProduct>? list) {
    if (list != null && list.isNotEmpty) {
      return Container(
        decoration: UiUtils.getBoxDecorationForCardsWithShadow(),
        child: ClipRRect(
          borderRadius: UIHelper.cardBorderRadiusAll,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  UIHelper.mediumPadding,
                  UIHelper.mediumPadding,
                  UIHelper.mediumPadding,
                  0,
                ),
                child: _getTitleWidget(
                  AppLocalizations.getLocalization().totalItems,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: list.length,

                itemBuilder: (BuildContext context, int index) {
                  return _getProductItemCard(list[index]);
                },
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _getProductItemCard(CartProduct? model) {
    if (model != null) {
      return CartProductItemCard(
        cartProduct: model,
        cartBloc: _cartBloc,
        onTap:
            model.productModel != null
                ? () {
                  _cartBloc?.navigateToProductDetailsScreen(
                    productModel: model.productModel,
                  );
                }
                : null,
      );
    }
    return const SizedBox();
  }

  Widget _getPaymentSummaryWidget(List<CartProduct> products) {
    int totalQuantity = 0;
    num totalPrice = 0;
    num deliveryFee = 10.00;

    for (int i = 0; i < products.length; i++) {
      int productQuantity = products[i].quantity ?? 0;
      num productPrice = products[i].productModel?.price ?? 0;
      if (productQuantity > 0) {
        totalQuantity = totalQuantity + productQuantity;
      }
      if (productPrice > 0) {
        totalPrice += productPrice * productQuantity;
      }
    }
    cartTotal = totalPrice + deliveryFee;

    return Container(
      decoration: UiUtils.getBoxDecorationForCardsWithShadow(),
      padding: const EdgeInsets.all(UIHelper.mediumPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTitleWidget(AppLocalizations.getLocalization().paymentSummary),
          UIHelper.verticalSpaceMedium,
          _getRowItemCell(
            label:
                "${AppLocalizations.getLocalization().subTotal} ($totalQuantity ${AppLocalizations.getLocalization().items.toLowerCase()})",
            value: CurrencyUtils.getValueWithCurrency(totalPrice) ?? "",
            labelTextColor: ThemePalette.secondaryText,
          ),
          UIHelper.verticalSpaceSmall,
          _getRowItemCell(
            label: AppLocalizations.getLocalization().deliveryFee,
            value: CurrencyUtils.getValueWithCurrency(deliveryFee),
            labelTextColor: ThemePalette.secondaryText,
          ),
          UIHelper.verticalSpaceMedium,
          _getRowItemCell(
            label: AppLocalizations.getLocalization().cartTotal,
            value: CurrencyUtils.getValueWithCurrency(cartTotal),
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _getRowItemCell({
    String? label,
    String? value,
    Color? labelTextColor,
    bool isBold = false,
  }) {
    if (label != null && label.isNotEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getTextWidget(label, textColor: labelTextColor, isBold: isBold),
          UIHelper.horizontalSpaceExtraSmall,
          if (value != null && value.isNotEmpty)
            _getTextWidget(value, isBold: isBold),
        ],
      );
    }
    return const SizedBox();
  }

  Widget _getTitleWidget(String title) {
    return Text(
      title,
      style: AppTextStyle.getLargeTextStyle(
        false,
        ThemePalette.primaryText,
        FontType.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getTextWidget(String text, {Color? textColor, bool isBold = false}) {
    return Text(
      text,
      style: AppTextStyle.getMediumTextStyle(
        false,
        textColor ?? ThemePalette.primaryText,
        isBold ? FontType.bold : FontType.medium,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getCheckoutButton() {
    return PrimaryButton(
      title:
          "${AppLocalizations.getLocalization().checkoutNow} | ${CurrencyUtils.getValueWithCurrency(cartTotal)}",
      onTap: () {},
      padding: EdgeInsets.symmetric(horizontal: UIHelper.smallPadding),
      textStyle: AppTextStyle.getMediumTextStyle(
        false,
        ThemePalette.selectedTextColor,
        FontType.bold,
      ),
    );
  }
}
