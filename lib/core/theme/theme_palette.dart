import 'package:flutter/material.dart';

import 'palette.dart';

enum CustomTheme { light, dark }

class ThemePalette {
  static Color get amber {
    return Colors.amber;
  }

  static get whiteColor {
    return Palette.whiteColor;
  }

  static get blackColor {
    return Palette.blackColor;
  }

  static get transparentColor {
    return Palette.transparentColor;
  }

  static Color get accentColor {
    return Palette.accentColor;
  }

  static Color get accentColorBg {
    return Palette.accentColor.withOpacity(0.1);
  }

  static get accentMedium {
    return Palette.accentMedium;
  }

  static get backgroundColor {
    return Palette.backgroundColor;
  }

  static get primaryText {
    return Palette.primaryText;
  }

  static get secondaryText {
    return Palette.secondaryText;
  }

  static get hintText {
    return Palette.hintText;
  }

  static get selectedTextColor {
    return Palette.whiteColor;
  }

  static get borderColor {
    return Palette.borderColor;
  }

  static Color get cellBackgroundColor {
    return Palette.whiteColor;

    // if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
    //     CustomTheme.dark) {
    //   return Palette.whiteColor;
    // } else {
    //   return Palette.whiteColor;
    // }
  }

  static get dividerColor {
    return Palette.dividerColor;
  }

  static get iconsColor {
    return Palette.iconsColor;
  }

  static get splashColor {
    return Palette.splashColor;
  }

  static get errorRedMessage {
    return Palette.errorRedMessage;
  }

  static get successGreenMessage {
    return Palette.successGreenMessage;
  }

  static get inActiveBgColor {
    return Palette.inActiveBgColor;
  }

  static get galleryBgColor {
    return Palette.galleryBgColor;
  }

  static get unSelectedColor {
    return Palette.unSelectedColor;
  }
}
