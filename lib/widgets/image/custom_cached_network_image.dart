import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';
import 'package:holo_challenge/r.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;
  final Color? bgColor;

  const CustomCachedNetworkImage(
    this.imageUrl, {
    super.key,
    this.boxFit = BoxFit.cover,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _getPlaceHolder();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _getPlaceHolder();
        },
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      memCacheWidth: 400,
      memCacheHeight: 400,
      maxWidthDiskCache: 600,
      maxHeightDiskCache: 800,
      color: bgColor,
      imageBuilder:
          (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: boxFit),
            ),
          ),
      placeholder: (context, url) => _getPlaceHolder(),
      errorWidget: (context, url, error) {
        return _getPlaceHolder();
      },
    );
  }

  Widget _getPlaceHolder() {
    return Center(
      child: Image.asset(
        R.assetsImagesIconsGallery,
        width: 24,
        height: 24,
        color: ThemePalette.hintText,
      ),
    );
  }
}
