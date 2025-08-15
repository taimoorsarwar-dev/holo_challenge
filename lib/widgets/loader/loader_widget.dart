import 'dart:math';

import 'package:flutter/material.dart';
import 'package:holo_challenge/core/theme/palette.dart';

enum DotType { square, circle, diamond, icon }

class LoaderWidget extends StatefulWidget {
  final Color color;
  final Icon dotIcon;
  final DotType dotType;
  final Duration duration;

  const LoaderWidget({
    super.key,
    this.dotType = DotType.circle,
    this.color = Palette.accentColor,
    this.dotIcon = const Icon(Icons.blur_on),
    this.duration = const Duration(milliseconds: 900),
  });

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation_1;
  Animation<double>? animation_2;
  Animation<double>? animation_3;
  Animation<double>? animation_4;
  AnimationController? controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation_1 = _buildAnimation(0.0, 0.70);
    animation_2 = _buildAnimation(0.1, 0.80);
    animation_3 = _buildAnimation(0.2, 0.90);
    animation_4 = _buildAnimation(0.3, 1.0);

    controller!.addListener(() => setState(() {}));
    controller!.repeat();
  }

  Animation<double> _buildAnimation(double start, double end) {
    return Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Interval(start, end, curve: Curves.linear),
      ),
    );
  }

  double _calculateOpacity(Animation<double> animation) {
    return (animation.value <= 0.4)
        ? 2.5 * animation.value
        : (animation.value > 0.40 && animation.value <= 0.60)
        ? 1.0
        : 2.5 - (2.5 * animation.value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildDot(animation_1!),
        _buildDot(animation_2!),
        _buildDot(animation_3!),
        _buildDot(animation_4!),
      ],
    );
  }

  Widget _buildDot(Animation<double> animation) {
    return Opacity(
      opacity: _calculateOpacity(animation),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Dot(
          radius: 10.0,
          color: widget.color,
          type: widget.dotType,
          icon: widget.dotIcon,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;
  final DotType? type;
  final Icon? icon;

  const Dot({super.key, this.radius, this.color, this.type, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          type == DotType.icon
              ? Icon(icon!.icon, color: color, size: 1.3 * radius!)
              : Transform.rotate(
                angle: type == DotType.diamond ? pi / 4 : 0.0,
                child: Container(
                  width: radius,
                  height: radius,
                  decoration: BoxDecoration(
                    color: color,
                    shape:
                        type == DotType.circle
                            ? BoxShape.circle
                            : BoxShape.rectangle,
                  ),
                ),
              ),
    );
  }
}
