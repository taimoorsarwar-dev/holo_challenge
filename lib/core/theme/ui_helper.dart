import 'package:flutter/material.dart';

import 'theme_palette.dart';

class UIHelper {
  //size
  static const double appBarButtonHeight = 38;
  static const double buttonHeight = 60;
  static const double outlineButtonHeight = 46;
  static const double chipButtonHeight = 36;
  static const double tagItemHeight = 32.0;
  static const double ctaButtonSize = 48;
  static const double imageHeight = 200;

  //padding
  static const double extraSmallPadding = 10;
  static const double smallPadding = 12;
  static const double mediumPadding = 16;
  static const double largePadding = 20;

  //radius
  static const double smallRadius = 6;
  static double mediumRadius = 8;
  static const double largeRadius = 10;
  static double extraLargeRadius = 12;
  static const double extraExtraLargeRadius = 100.0;

  //elevation
  static const double cardElevation = 0.0;
  static const double appBarElevation = 0.0;

  static const Widget horizontalSpaceSmall = SizedBox(width: spaceTen);
  static const Widget horizontalSpaceExtraSmall = SizedBox(width: spaceFive);

  static const double spaceFour = 4.0;
  static const double spaceFive = 5.0;
  static const double spaceSix = 6.0;
  static const double spaceEight = 8.0;
  static const double spaceTen = 10.0;

  static customHorizontalSizedBox(double width) {
    return SizedBox(width: width);
  }

  static customVerticalSizedBox(double height) {
    return SizedBox(height: height);
  }

  static EdgeInsets cardPaddingAll = const EdgeInsets.all(mediumPadding);

  static BorderRadius cardBorderRadiusAll = const BorderRadius.all(
    Radius.circular(UIHelper.largeRadius),
  );

  static BorderRadius getBorderRadius({double? radius}) {
    return BorderRadius.circular(radius ?? extraLargeRadius);
  }

  static Border getBorder({Color? color, double width = 1.0}) {
    return Border.all(color: color ?? ThemePalette.borderColor, width: width);
  }
}
