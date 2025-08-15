import 'package:flutter/material.dart';
import 'package:holo_challenge/core/theme/theme_palette.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Function(double)? onRatingChanged;
  final Color? iconColor;

  const StarRating({
    super.key,
    this.starCount = 5,
    this.rating = 0.0,
    this.onRatingChanged,
    this.iconColor,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    Color color = iconColor ?? ThemePalette.amber;
    if (index >= rating) {
      icon = Icon(Icons.star_border, color: color);
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(Icons.star_half, color: color);
    } else {
      icon = Icon(Icons.star, color: color);
    }

    return GestureDetector(
      onTap:
          onRatingChanged == null
              ? null
              : () {
                onRatingChanged!(index + 1.0);
              },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }
}
