import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    this.size,
    this.color,
    this.strokeWidth,
  });

  final double? size;
  final Color? color;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 20.rm,
      height: size ?? 20.rm,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth ?? 2,
      ),
    );
  }
}
