import 'package:flutter/material.dart';
import 'package:holo_challenge/core/di/app_locator.dart';
import 'package:holo_challenge/modules/user/user_preferences_bloc.dart';

import 'palette.dart';

enum CustomTheme { light, dark }

class ThemePalette {
  static Color get amber {
    return Colors.amber;
  }

  static get whiteColor {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.blackColor;
    } else {
      return Palette.whiteColor;
    }
  }

  static get blackColor {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.whiteColor;
    } else {
      return Palette.blackColor;
    }
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
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.accentMediumDark;
    } else {
      return Palette.accentMedium;
    }
  }

  static get backgroundColor {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.backgroundColorDark;
    } else {
      return Palette.backgroundColor;
    }
  }

  static get primaryText {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.primaryTextDark;
    } else {
      return Palette.primaryText;
    }
  }

  static get secondaryText {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.secondaryTextDark;
    } else {
      return Palette.secondaryText;
    }
  }

  static get hintText {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.hintTextDark;
    } else {
      return Palette.hintText;
    }
  }

  static get selectedTextColor {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.cellBackgroundColorDark;
    } else {
      return Palette.whiteColor;
    }
  }

  static get borderColor {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.borderColorDark;
    } else {
      return Palette.borderColor;
    }
  }

  static Color get cellBackgroundColor {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.cellBackgroundColorDark;
    } else {
      return Palette.whiteColor;
    }
  }

  static get dividerColor {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.dividerColorDark;
    } else {
      return Palette.dividerColor;
    }
  }

  static get iconsColor {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.iconsColorDark;
    } else {
      return Palette.iconsColor;
    }
  }

  static get splashColor {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.splashColorDark;
    } else {
      return Palette.splashColor;
    }
  }

  static get errorRedMessage {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.errorRedMessage;
    } else {
      return Palette.errorRedMessage;
    }
  }

  static get successGreenMessage {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.successGreenMessage;
    } else {
      return Palette.successGreenMessage;
    }
  }

  static get inActiveBgColor {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.inActiveBgColorDark;
    } else {
      return Palette.inActiveBgColor;
    }
  }

  static get galleryBgColor {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.galleryBgColorDark;
    } else {
      return Palette.galleryBgColor;
    }
  }

  static get unSelectedColor {
    if (locator<UserPreferencesBloc>().userPreferences.selectedTheme ==
        CustomTheme.dark) {
      return Palette.unSelectedColorDark;
    } else {
      return Palette.unSelectedColor;
    }
  }
}
