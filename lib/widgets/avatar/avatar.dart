import 'package:flutter/material.dart';
import 'package:holo_challenge/core/theme/ui_theme.dart';
import 'package:holo_challenge/r.dart';

class AvatarWidget extends StatelessWidget {
  final VoidCallback? onProfileClick;
  final bool needRightPadding;
  final bool isCircular;

  const AvatarWidget({
    super.key,
    this.onProfileClick,
    this.needRightPadding = false,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return getProfileImage(context);
  }

  Widget getProfileImage(BuildContext context) {
    double imageSize = UIHelper.appBarButtonHeight;
    double iconSize = imageSize * 0.5;
    List<Color> gradient = [const Color(0xFFD7E0F3), const Color(0xFF61B3FF)];

    return Container(
      margin:
          needRightPadding
              ? EdgeInsets.only(right: UIHelper.mediumPadding)
              : EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          if (onProfileClick != null) {
            onProfileClick!();
          }
        },
        child: Container(
          height: imageSize,
          width: imageSize,
          decoration:
              isCircular
                  ? BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [gradient.first, gradient.last],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  )
                  : BoxDecoration(
                    borderRadius: UIHelper.getBorderRadius(
                      radius: UIHelper.smallRadius,
                    ),
                    gradient: LinearGradient(
                      colors: [gradient.first, gradient.last],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
          child: Center(
            child: Image.asset(
              R.assetsImagesIconsProfile,
              width: iconSize,
              height: iconSize,
              color: ThemePalette.selectedTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
