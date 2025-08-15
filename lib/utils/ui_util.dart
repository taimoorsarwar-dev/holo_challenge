import 'package:flutter/material.dart';
import 'package:holo_challenge/core/theme/app_text_styles.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';
import 'package:holo_challenge/core/theme/ui_helper.dart';
import 'package:holo_challenge/widgets/image/multi_source_image.dart';

class UiUtils {
  static BoxDecoration getBoxDecorationForCardsWithShadow({
    double borderRadius = UIHelper.largeRadius,
    Color? backgroundColor,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      color: backgroundColor ?? ThemePalette.cellBackgroundColor,
    );
  }

  static Widget getChipItemCell({
    String? label,
    String? icon,
    Color? bgColor,
    Color? textColor,
    Color? borderColor,
  }) {
    Widget imageWidget = Container();
    if (icon != null && icon.isNotEmpty) {
      imageWidget = Row(
        children: [
          MultiSourceImage(url: icon, iconColor: textColor),
          UIHelper.horizontalSpaceExtraSmall,
        ],
      );
    }
    if (label != null && label.isNotEmpty) {
      return Container(
        height: UIHelper.tagItemHeight,
        decoration: BoxDecoration(
          color: bgColor ?? ThemePalette.cellBackgroundColor,
          border:
              borderColor != null
                  ? UIHelper.getBorder(color: borderColor)
                  : null,
          borderRadius: BorderRadius.all(
            Radius.circular(UIHelper.mediumRadius),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: UIHelper.extraSmallPadding,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            imageWidget,
            Text(
              label,
              style: AppTextStyle.getSmallTextStyle(
                false,
                textColor ?? ThemePalette.blackColor,
                FontType.bold,
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
