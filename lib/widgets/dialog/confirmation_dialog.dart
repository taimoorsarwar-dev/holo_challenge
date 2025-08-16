import 'package:flutter/material.dart';
import 'package:holo_challenge/core/theme/ui_theme.dart';
import 'package:holo_challenge/r.dart';
import 'package:holo_challenge/widgets/buttons/custom_outlined.dart';
import 'package:holo_challenge/widgets/buttons/primary_button.dart';
import 'package:holo_challenge/widgets/image/multi_source_image.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback? positiveIsClicked;
  final VoidCallback? negativeIsClicked;
  final String? positiveBtnText;
  final String? negativeBtnText;
  final String? title;
  final String? description;
  final String? icon;
  final Color? iconBgColor;
  final Color? iconColor;
  final Color? positiveFillColor;
  final Color? positiveTextColor;
  final bool canPop;

  const ConfirmationDialog({
    super.key,
    this.positiveIsClicked,
    this.title,
    this.positiveBtnText,
    this.description,
    this.icon,
    this.negativeIsClicked,
    this.negativeBtnText,
    this.iconBgColor,
    this.iconColor,
    this.positiveFillColor,
    this.positiveTextColor,
    this.canPop = true,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: AlertDialog(
        backgroundColor: ThemePalette.cellBackgroundColor,
        elevation: UIHelper.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: UIHelper.getBorderRadius(radius: UIHelper.smallRadius),
        ),
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        content: _getBody(context),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (UIHelper.largePadding * 2),
      padding: const EdgeInsets.all(UIHelper.largePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _getIconWidget(),
          _getTitleWidget(),
          _getDescriptionWidget(),
          UIHelper.verticalSpaceSmall,
          _getButtonsWidget(),
        ],
      ),
    );
  }

  Widget _getIconWidget() {
    return Container(
      width: UIHelper.outlineButtonHeight,
      height: UIHelper.outlineButtonHeight,
      decoration: BoxDecoration(
        color: iconBgColor ?? ThemePalette.accentColorBg,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: MultiSourceImage(
          url: icon ?? R.assetsImagesIconsWarning,
          iconColor: iconColor ?? ThemePalette.accentColor,
        ),
      ),
    );
  }

  Widget _getTitleWidget() {
    String? text = title;
    if (text != null && text.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: UIHelper.mediumPadding),
        child: Text(
          text,
          style: AppTextStyle.getSemiMediumTextStyle(
            true,
            ThemePalette.primaryText,
            FontType.bold,
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _getDescriptionWidget() {
    String? text = description;
    if (text != null && text.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: UIHelper.mediumPadding),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyle.getMediumTextStyle(
            false,
            ThemePalette.primaryText,
            FontType.regular,
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _getButtonsWidget() {
    List<Widget> list = [];

    if (negativeBtnText != null) {
      list.add(
        Expanded(
          child: CustomOutlinedButton(
            height: UIHelper.buttonHeight,
            radius: UIHelper.smallRadius,
            isBoldText: true,
            title: negativeBtnText,
            onTap: () {
              if (negativeIsClicked != null) {
                negativeIsClicked!();
              }
            },
          ),
        ),
      );
    }

    if (positiveBtnText != null) {
      list.add(
        Expanded(
          child: PrimaryButton(
            backgroundColor: positiveFillColor ?? ThemePalette.accentColor,
            textColor: positiveTextColor ?? ThemePalette.selectedTextColor,
            title: positiveBtnText,
            radius: UIHelper.smallRadius,
            onTap: () {
              if (positiveIsClicked != null) {
                positiveIsClicked!();
              }
            },
          ),
        ),
      );
    }

    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        if (i % 2 == 1) {
          list.insert(
            i,
            UIHelper.customHorizontalSizedBox(UIHelper.smallPadding),
          );
        }
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: UIHelper.extraLargePadding),
      child: Row(children: list),
    );
  }
}
