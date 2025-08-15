import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';
import 'package:holo_challenge/core/theme/ui_helper.dart';
import 'package:holo_challenge/r.dart';
import 'package:holo_challenge/utils/validation_utils.dart';

enum ButtonIconSize {
  extraExtraExtraSmall,
  extraExtraSmall,
  extraSmall,
  small,
  medium,
  large,
  cta,
}

class MultiSourceImage extends StatelessWidget {
  final String? url;
  final Color? iconColor;
  final double? borderRadius;
  final ButtonIconSize? buttonIconSize;
  final bool isLogo;

  const MultiSourceImage({
    super.key,
    required this.url,
    this.iconColor,
    this.borderRadius,
    this.buttonIconSize = ButtonIconSize.medium,
    this.isLogo = false,
  });

  @override
  Widget build(BuildContext context) {
    final radius =
        borderRadius != null ? UIHelper.getBorderRadius() : BorderRadius.zero;

    return ClipRRect(
      borderRadius: radius,
      child: _buildImage(url: url, iconColor: iconColor),
    );
  }

  double _getIconSize() {
    const sizeMap = {
      ButtonIconSize.extraExtraExtraSmall: 12.0,
      ButtonIconSize.extraExtraSmall: 16.0,
      ButtonIconSize.extraSmall: 18.0,
      ButtonIconSize.small: 20.0,
      ButtonIconSize.medium: 24.0,
      ButtonIconSize.large: 32.0,
      ButtonIconSize.cta: 28.0,
    };

    return sizeMap[buttonIconSize] ?? 24.0;
  }

  Widget _buildImage({required String? url, Color? iconColor}) {
    final size = _getIconSize();
    final color = iconColor ?? ThemePalette.primaryText;

    if (url != null && url.isNotEmpty) {
      bool isImageSvg = false;
      bool isUrl = false;
      isUrl = ValidationUtils.isUrl(url);
      if (url.substring(url.lastIndexOf(".")) == ".svg") {
        isImageSvg = true;
      }
      if (isImageSvg) {
        Widget svgImage =
            isUrl
                ? SvgPicture.network(
                  url,
                  width: size,
                  height: size,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  placeholderBuilder:
                      (BuildContext context) => _iconPlaceholder(size),
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      R.assetsImagesIconsGallery,
                      width: size,
                      height: size,
                    );
                  },
                )
                : SvgPicture.asset(
                  url,
                  width: size,
                  height: size,
                  color: color,
                );
        return svgImage;
      } else if (isUrl && !isImageSvg) {
        return CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: size,
          height: size,
          color: color,
          alignment: Alignment.center,
          placeholder: (context, url) => _iconPlaceholder(size),
          errorWidget: (context, url, error) => _iconPlaceholder(size),
        );
      } else {
        return Image.asset(
          url,
          width: size,
          height: size,
          color: isLogo ? null : iconColor,
          fit: BoxFit.cover,
        );
      }
    }
    return Container();
  }

  static Widget _iconPlaceholder(double size) {
    return Image.asset(
      R.assetsImagesIconsGallery,
      width: size,
      height: size,
      color: ThemePalette.iconsColor,
    );
  }
}
