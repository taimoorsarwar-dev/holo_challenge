import 'package:flutter/material.dart';

class CustomPopScope extends StatelessWidget {
  final bool canPop;
  final void Function(dynamic result)? onBackPressed;
  final Widget child;

  const CustomPopScope({
    super.key,
    this.canPop = false,
    this.onBackPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // System or swipe back gesture succeeded — let it go
          return;
        }
        // If back button pressed or manual pop attempt
        if (onBackPressed != null) {
          onBackPressed!(result);
        }
      },
      child: child,
    );
  }
}
