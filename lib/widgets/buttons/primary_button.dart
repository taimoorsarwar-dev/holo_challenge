import 'package:flutter/material.dart';
import 'package:holo_challenge/widgets/image/multi_source_image.dart';
import 'package:holo_challenge/core/theme/ui_theme.dart';

class PrimaryButton extends StatelessWidget {
  final Color? backgroundColor;
  final ButtonIconSize buttonIconSize;
  final double? elevation;
  final double? height;
  final String? icon;
  final bool isOutlined;
  final bool isTransparent;
  final bool isLogo;
  final VoidCallback? onTap;
  final double radius;
  final double? minWidth;
  final Widget? suffix;
  final String? suffixIcon;
  final Color? textColor;
  final Color? borderColor;
  final Color? disabledColor;
  final TextStyle? textStyle;
  final String? title;
  final EdgeInsets? padding;

  const PrimaryButton({
    super.key,
    this.title,
    this.icon,
    this.suffix,
    this.suffixIcon,
    this.onTap,
    this.textColor,
    this.borderColor,
    this.disabledColor,
    this.backgroundColor,
    this.elevation,
    this.height,
    this.textStyle,
    this.padding,
    this.minWidth,
    this.isTransparent = false,
    this.isOutlined = false,
    this.isLogo = false,
    this.radius = UIHelper.largeRadius,
    this.buttonIconSize = ButtonIconSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return getButton(
      title: title,
      icon: icon,
      onTap: onTap,
      radius: radius,
      height: height,
      suffix: suffix,
      isOutlined: isOutlined,
      suffixIcon: suffixIcon,
      elevation: elevation,
      textStyle: textStyle,
      textColor: textColor,
      borderColor: borderColor,
      disabledColor: disabledColor,
      isTransparent: isTransparent,
      isLogo: isLogo,
      backgroundColor: backgroundColor,
      buttonIconSize: buttonIconSize,
      padding: padding,
      minWidth: minWidth,
    );
  }

  Widget getButton({
    String? title,
    String? icon,
    Widget? suffix,
    String? suffixIcon,
    VoidCallback? onTap,
    Color? textColor,
    Color? disabledColor,
    Color? backgroundColor,
    Color? borderColor,
    double? elevation,
    double? height,
    TextStyle? textStyle,
    bool isTransparent = false,
    bool isOutlined = false,
    bool isLogo = false,
    EdgeInsets? padding,
    double? minWidth,
    double radius = UIHelper.largeRadius,
    ButtonIconSize buttonIconSize = ButtonIconSize.medium,
  }) {
    disabledColor ??= ThemePalette.unSelectedColor;
    textColor ??=
        isTransparent
            ? ThemePalette.primaryText
            : ThemePalette.selectedTextColor;
    backgroundColor ??= ThemePalette.accentColor;
    Color _borderColor = borderColor ?? ThemePalette.inActiveBgColor;
    BorderRadius borderRadius = UIHelper.getBorderRadius(radius: radius);

    return MaterialButton(
      onPressed: onTap,
      minWidth: minWidth,
      elevation: elevation ?? UIHelper.cardElevation,
      height: height ?? UIHelper.buttonHeight,
      color: isTransparent ? null : backgroundColor,
      disabledColor: disabledColor,
      disabledTextColor: ThemePalette.secondaryText,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textColor: textColor,
      padding: padding ?? EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: isOutlined ? BorderSide(color: _borderColor) : BorderSide.none,
        borderRadius: borderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null && icon.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: UIHelper.spaceEight),
              child: MultiSourceImage(
                url: icon,
                iconColor: textColor,
                buttonIconSize: buttonIconSize,
                isLogo: isLogo,
              ),
            ),
          Text(
            title ?? '',
            style:
                textStyle ??
                AppTextStyle.getMediumTextStyle(
                  false,
                  textColor,
                  FontType.bold,
                ),
          ),
          if (suffix != null)
            Container(
              padding: const EdgeInsets.only(left: UIHelper.spaceEight),
              child: suffix,
            ),
          if (suffixIcon != null && suffixIcon.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: UIHelper.spaceEight),
              child: MultiSourceImage(
                url: suffixIcon,
                iconColor: textColor,
                buttonIconSize: buttonIconSize,
              ),
            ),
        ],
      ),
    );
  }
}
