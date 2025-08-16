import 'package:flutter/material.dart';

import 'app_responsive.dart';

enum FontType { regular, medium, bold }

class AppTextStyle {
  static const String _fontRegular = "PoppinsRegular";
  static const String _fontMedium = "PoppinsMedium";
  // static const String _fontSemiBold = "PoppinsSemiBold";
  static const String _fontHeadingBold = "PoppinsBold";

  static const double _fontSizeExtraSmall = 10;
  static const double _fontSizeSmall = 12;
  static const double _fontSizeMedium = 14;
  static const double _fontSizeLarge = 16;
  static const double _fontSizeSemiMedium = 18;
  static const double _fontSizeExtraLarge = 22;

  static const double _lineHeight = 1.2;

  static FontWeight _getFontWeight(bool isBold) {
    FontWeight fontWeight = FontWeight.normal;
    if (isBold) {
      fontWeight = FontWeight.bold;
    }
    return fontWeight;
  }

  static String _getFont(FontType fontType) {
    if (fontType == FontType.medium) {
      return _fontMedium;
    } else if (fontType == FontType.regular) {
      return _fontRegular;
    } else if (fontType == FontType.bold) {
      return _fontHeadingBold;
    }
    return _fontRegular;
  }

  static TextStyle getExtraSmallStyle(
    bool isBold,
    Color color,
    FontType fontType,
  ) {
    return TextStyle(
      fontWeight: _getFontWeight(isBold),
      fontStyle: FontStyle.normal,
      color: color,
      height: _lineHeight,
      fontSize: AppResponsive.getFontSizeOf(_fontSizeExtraSmall),
      fontFamily: _getFont(fontType),
    );
  }

  static TextStyle getSmallTextStyle(
    bool isBold,
    Color color,
    FontType fontType, {
    double lineHeight = _lineHeight,
  }) {
    return TextStyle(
      fontWeight: _getFontWeight(isBold),
      fontStyle: FontStyle.normal,
      color: color,
      height: lineHeight,
      fontSize: AppResponsive.getFontSizeOf(_fontSizeSmall),
      fontFamily: _getFont(fontType),
    );
  }

  static TextStyle getMediumTextStyle(
    bool isBold,
    Color? color,
    FontType fontType, {
    double lineHeight = _lineHeight,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      decoration: textDecoration,
      fontWeight: _getFontWeight(isBold),
      fontStyle: FontStyle.normal,
      color: color,
      height: lineHeight,
      fontSize: AppResponsive.getFontSizeOf(_fontSizeMedium),
      fontFamily: _getFont(fontType),
    );
  }

  static TextStyle getSemiMediumTextStyle(
    bool isBold,
    Color? color,
    FontType fontType, {
    double lineHeight = _lineHeight,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      decoration: textDecoration,
      fontWeight: _getFontWeight(isBold),
      fontStyle: FontStyle.normal,
      color: color,
      height: lineHeight,
      fontSize: AppResponsive.getFontSizeOf(_fontSizeSemiMedium),
      fontFamily: _getFont(fontType),
    );
  }

  static TextStyle getLargeTextStyle(
    bool isBold,
    Color color,
    FontType fontType, {
    double? lineHeight,
  }) {
    lineHeight ??= _lineHeight;
    return TextStyle(
      fontWeight: _getFontWeight(isBold),
      fontStyle: FontStyle.normal,
      color: color,
      height: lineHeight,
      fontSize: AppResponsive.getFontSizeOf(_fontSizeLarge),
      fontFamily: _getFont(fontType),
    );
  }

  static TextStyle getExtraLargeTextStyle(
    bool isBold,
    Color color,
    FontType fontType,
  ) {
    return TextStyle(
      fontWeight: _getFontWeight(isBold),
      fontStyle: FontStyle.normal,
      color: color,
      height: _lineHeight,
      fontSize: AppResponsive.getFontSizeOf(_fontSizeExtraLarge),
      fontFamily: _getFont(fontType),
    );
  }
}
