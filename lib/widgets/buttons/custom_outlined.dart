import 'package:flutter/material.dart';
import 'package:holo_challenge/r.dart';
import 'package:holo_challenge/widgets/image/multi_source_image.dart';

import '../../core/theme/ui_theme.dart';
import 'custom_icon_button.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Color? borderColor;
  final ButtonIconSize? buttonIconSize;
  final double? height;
  final String? icon;
  final Color? iconColor;
  final bool isBoldText;
  final bool isFilled;
  final bool isSelected;
  final VoidCallback? onRemoveTap;
  final VoidCallback? onTap;
  final double? radius;
  final bool showRemove;
  final double showRemoveMargin;
  final String? suffixIcon;
  final String? title;
  final EdgeInsets? padding;

  const CustomOutlinedButton({
    super.key,
    this.title,
    this.icon,
    this.height,
    this.onTap,
    this.onRemoveTap,
    this.iconColor,
    this.suffixIcon,
    this.borderColor,
    this.isFilled = false,
    this.isSelected = false,
    this.showRemove = false,
    this.isBoldText = false,
    this.showRemoveMargin = 0,
    this.radius = UIHelper.smallRadius,
    this.buttonIconSize = ButtonIconSize.small,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return getOutlinedButton(
      title: title,
      icon: icon,
      onTap: onTap,
      height: height,
      radius: radius,
      isFilled: isFilled,
      isSelected: isSelected,
      showRemove: showRemove,
      isBoldText: isBoldText,
      iconColor: iconColor,
      suffixIcon: suffixIcon,
      borderColor: borderColor,
      onRemoveTap: onRemoveTap,
      buttonIconSize: buttonIconSize,
      showRemoveMargin: showRemoveMargin,
      padding: padding,
    );
  }

  Widget getOutlinedButton({
    String? title,
    String? icon,
    int? count,
    double? height,
    double? radius = UIHelper.smallRadius,
    Color? fillColor,
    Color? borderColor,
    Color? defaultTextColor,
    Color? iconColor,
    String? suffixIcon,
    double showRemoveMargin = 0,
    VoidCallback? onRemoveTap,
    bool isFilled = false,
    bool isSelected = false,
    bool showRemove = false,
    bool isBoldText = false,
    EdgeInsets? padding,
    ButtonIconSize? buttonIconSize = ButtonIconSize.small,
    VoidCallback? onTap,
  }) {
    Color backgroundColor =
        fillColor ??
        (isFilled && isSelected
            ? ThemePalette.accentColor
            : ThemePalette.cellBackgroundColor);
    Color _borderColor =
        isSelected
            ? ThemePalette.accentColor
            : borderColor ?? ThemePalette.borderColor;
    defaultTextColor ??= ThemePalette.primaryText;
    Color textColor =
        isSelected
            ? isFilled
                ? ThemePalette.selectedTextColor
                : ThemePalette.accentColor
            : defaultTextColor;
    height ??= UIHelper.chipButtonHeight;

    if (title != null && title.isNotEmpty) {
      return OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: _borderColor),
          foregroundColor: ThemePalette.splashColor,
          minimumSize: Size(height, height),
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: UIHelper.smallPadding,
                vertical: UIHelper.spaceSix,
              ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: UIHelper.getBorderRadius(radius: radius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null && icon.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(right: UIHelper.spaceSix),
                child: _getPrefixIconWidget(
                  icon: icon,
                  iconColor:
                      iconColor != null && !isFilled && !isSelected
                          ? iconColor
                          : textColor,
                  buttonIconSize: buttonIconSize,
                ),
              ),
            Text(
              title,
              style: AppTextStyle.getMediumTextStyle(
                false,
                textColor,
                isBoldText ? FontType.bold : FontType.medium,
              ),
            ),
            if (isFilled) CountWidget(count: count),
            if (suffixIcon != null && suffixIcon.isNotEmpty && !isSelected)
              Container(
                margin: const EdgeInsets.only(left: UIHelper.spaceSix),

                child: MultiSourceImage(url: suffixIcon, iconColor: textColor),
              ),
            if (showRemove && isSelected)
              Container(
                margin: EdgeInsets.only(left: showRemoveMargin),
                child: InkWell(
                  onTap: onRemoveTap,
                  child: MultiSourceImage(
                    url: R.assetsImagesIconsDelete,
                    iconColor: textColor,
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _getPrefixIconWidget({
    required String? icon,
    Color? iconColor,
    ButtonIconSize? buttonIconSize,
  }) {
    return MultiSourceImage(
      url: icon,
      buttonIconSize: buttonIconSize,
      iconColor: iconColor,
    );
  }
}
