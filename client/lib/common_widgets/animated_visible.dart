import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedVisible extends StatelessWidget {
  const AnimatedVisible({
    super.key,
    required this.visible,
    required this.child,
    required this.height,
  });

  final bool visible;
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 300.ms,
      curve: Curves.easeInOut,
      constraints: BoxConstraints(
        maxHeight: visible ? height : 0,
      ),
      child: AnimatedOpacity(
        duration: 400.ms,
        opacity: visible ? 1 : 0,
        child: child,
      ),
    );
  }
}
