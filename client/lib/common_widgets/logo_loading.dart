import 'package:client/assets/assets.gen.dart';
import 'package:client/common_widgets/svg_icon.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class LogoLoading extends StatelessWidget {
  const LogoLoading({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? 58;
    final strokeWidth = size * 0.05;
    final logoSize = size * 0.5;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.square(
          dimension: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(
              context.colors.primary,
            ),
            strokeCap: StrokeCap.round,
            backgroundColor: context.colors.primary.withOpacity(0.2),
          ),
        ),
        SvgIcon(
          Assets.logo.logoSvg.path,
          size: logoSize,
          color: context.colors.primary,
        ),
      ],
    );
  }
}
