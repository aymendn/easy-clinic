import 'package:client/extensions/color_extensions.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedPageView extends StatelessWidget {
  const RoundedPageView({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.margin,
    required this.child,
  });

  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        margin:
            margin ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 24.h,
            ),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          color: backgroundColor ??
              context.colors.primary.withOpacity(0.06).mergeWithWhite(),
        ),
        child: child,
      ),
    );
  }
}
