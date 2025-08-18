import 'package:flutter/material.dart';
import 'package:holo_challenge/core/theme/app_text_styles.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';
import 'package:holo_challenge/core/theme/ui_helper.dart';
import 'package:holo_challenge/widgets/image/multi_source_image.dart';

class CustomIconButton extends StatelessWidget {
  final ButtonIconSize? buttonIconSize;
  final int? count;
  final Color? borderColor;
  final Color? fillColor;
  final Color? counterFillColor;
  final String? icon;
  final Color? iconColor;
  final bool isCircular;
  final bool isSelected;
  final bool isTransparent;
  final VoidCallback? onTap;
  final bool showBorder;
  final double size;
  final double radius;

  const CustomIconButton({
    super.key,
    this.icon,
    this.count,
    this.onTap,
    this.iconColor,
    this.borderColor,
    this.fillColor,
    this.counterFillColor,
    this.isSelected = false,
    this.isCircular = false,
    this.showBorder = false,
    this.isTransparent = false,
    this.size = UIHelper.ctaButtonSize,
    this.radius = UIHelper.largeRadius,
    this.buttonIconSize = ButtonIconSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return _getIconButton(
      icon: icon,
      onTap: onTap,
      size: size,
      count: count,
      iconColor: iconColor,
      fillColor: fillColor,
      borderColor: borderColor,
      counterFillColor: counterFillColor,
      isSelected: isSelected,
      isCircular: isCircular,
      showBorder: showBorder,
      isTransparent: isTransparent,
      buttonIconSize: buttonIconSize,
    );
  }

  Widget _getIconButton({
    String? icon,
    VoidCallback? onTap,
    Color? iconColor,
    Color? fillColor,
    Color? counterFillColor,
    Color? borderColor,
    double size = UIHelper.ctaButtonSize,
    int? count,
    bool isSelected = false,
    bool isCircular = false,
    bool showBorder = false,
    bool isTransparent = false,
    ButtonIconSize? buttonIconSize = ButtonIconSize.medium,
  }) {
    iconColor ??=
        isSelected ? ThemePalette.selectedTextColor : ThemePalette.primaryText;
    Color backgroundColor =
        fillColor ??
        (isTransparent
            ? ThemePalette.transparentColor
            : isSelected
            ? ThemePalette.accentColor
            : ThemePalette.cellBackgroundColor);
    Color borderColor0 = borderColor ?? ThemePalette.borderColor;
    if (icon != null && icon.isNotEmpty) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            onPressed: onTap,
            padding: EdgeInsets.zero,
            splashColor: ThemePalette.splashColor,
            icon: MultiSourceImage(
              url: icon,
              iconColor: iconColor,
              buttonIconSize: buttonIconSize,
            ),
            style: IconButton.styleFrom(
              minimumSize: Size(size, size),
              backgroundColor: backgroundColor,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: UIHelper.getBorderRadius(
                  radius: isCircular ? UIHelper.extraExtraLargeRadius : radius,
                ),
                side:
                    showBorder
                        ? BorderSide(color: borderColor0)
                        : BorderSide.none,
              ),
            ),
          ),
          if (count != null && count > 0)
            Positioned(
              right: -(size * 0.10),
              top: -(size * 0.10),
              child: CountWidget(
                count: count,
                isBadge: true,
                counterFillColor: counterFillColor,
              ),
            ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

class CountWidget extends StatelessWidget {
  const CountWidget({
    super.key,
    this.count,
    this.isBadge = false,
    this.counterFillColor,
  });

  final int? count;
  final bool isBadge;
  final Color? counterFillColor;
  final int maxCount = 99;

  @override
  Widget build(BuildContext context) {
    bool isMaxCount = (count ?? 0) > maxCount;
    double size = isMaxCount ? 24 : 20;
    if ((count ?? 0) > 0) {
      return Container(
        width: size,
        height: size,
        margin: const EdgeInsets.only(left: UIHelper.spaceFour),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              isBadge
                  ? (counterFillColor ?? ThemePalette.accentColor)
                  : ThemePalette.whiteColor,
        ),
        child: Center(
          child: Text(
            '${isMaxCount ? '$maxCount+' : count}',
            style:
                isBadge
                    ? AppTextStyle.getExtraSmallStyle(
                      false,
                      ThemePalette.selectedTextColor,
                      FontType.medium,
                    )
                    : AppTextStyle.getSmallTextStyle(
                      true,
                      ThemePalette.accentColor,
                      FontType.medium,
                    ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
