import 'package:client/assets/assets.gen.dart';
import 'package:client/common_widgets/svg_icon.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgIcon(
          Assets.logo.logoSvg.path,
          color: context.colors.primary,
          size: 24.rm,
        ),
        8.gapW,
        Text(
          'EasyClinic',
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colors.primary,
            fontSize: 28.spMin,
            fontWeight: FontWeight.w600,
            letterSpacing: -1.2.spMin,
          ),
        ),
      ],
    );
  }
}
