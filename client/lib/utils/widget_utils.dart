import 'package:client/common_widgets/svg_icon.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:flutter/material.dart';



abstract class WidgetUtils {
  static OutlineInputBorder border(Color color,
      [double? width, double? radius]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 50),
      borderSide: BorderSide(
        color: color,
        width: width ?? 1,
      ),
    );
  }

  // border with only borderRadius
  static OutlineInputBorder borderOnlyRadius([double? radius]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 100),
      borderSide: BorderSide.none,
    );
  }

  static Widget? fieldPrefix({
    required BuildContext context,
    required String? prefixIconPath,
    required Widget? prefix,
  }) {
    if (prefix != null) return prefix;
    if (prefixIconPath == null) return null;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.hm, vertical: 16.wm),
      child: SvgIcon(
        prefixIconPath,
        size: 24.rm,
        color: context.colors.label,
      ),
    );
  }

  static Widget? fieldSuffix({
    required Widget? statusIcon,
    required Widget? suffixPasswordIcon,
    required Widget? suffixHelpIcon,
  }) {
    if (statusIcon == null &&
        suffixPasswordIcon == null &&
        suffixHelpIcon == null) {
      return null;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (statusIcon != null) statusIcon,
        if (suffixPasswordIcon != null) suffixPasswordIcon,
        if (suffixHelpIcon != null) suffixHelpIcon,
        6.gapW,
      ],
    );
  }
}
