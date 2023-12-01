import 'package:client/common_widgets/custom_ink_well.dart';
import 'package:client/common_widgets/svg_icon.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:flutter/material.dart';



class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    super.key,
    required this.iconPath,
    this.color,
    this.size,
    this.onTap,
  });

  final String? iconPath;
  final Color? color;
  final double? size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (iconPath == null) return const SizedBox.shrink();

    Widget icon() {
      return Padding(
        padding: EdgeInsets.all(14.rm),
        child: SvgIcon(
          iconPath!,
          size: size ?? 22.rm,
          color: color ?? context.colors.label,
        ),
      );
    }

    if (onTap == null) return icon();
    return CustomInkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: icon(),
    );
  }
}
