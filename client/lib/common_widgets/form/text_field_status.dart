import 'package:client/assets/assets.gen.dart';
import 'package:client/common_widgets/svg_icon.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:flutter/material.dart';



enum TextFieldStatus {
  normal,
  error,
  success;

  Color color(BuildContext context) {
    switch (this) {
      case TextFieldStatus.normal:
        return context.colors.stroke;
      case TextFieldStatus.error:
        return context.colors.error;
      case TextFieldStatus.success:
        return context.colors.success;
    }
  }

  Color iconColor(BuildContext context) {
    switch (this) {
      case TextFieldStatus.normal:
        return context.colors.label;
      case TextFieldStatus.error:
        return context.colors.error;
      case TextFieldStatus.success:
        return context.colors.success;
    }
  }

  Widget? statusIcon() {
    switch (this) {
      case TextFieldStatus.normal:
        return null;
      case TextFieldStatus.error:
        return Assets.icons.cross.svg();
      case TextFieldStatus.success:
        return Assets.icons.check.svg();
    }
  }

  String? statusIconPath() {
    switch (this) {
      case TextFieldStatus.normal:
        return null;
      case TextFieldStatus.error:
        return Assets.icons.cross.path;
      case TextFieldStatus.success:
        return Assets.icons.check.path;
    }
  }

  Widget? statucIconWithColor(BuildContext context) {
    if (statusIconPath() == null) return null;
    return SvgIcon(
      statusIconPath()!,
      size: 24.rm,
      color: color(context),
    );
  }

  static TextFieldStatus getStatusFromValueAndError(
      String? value, String? error) {
    if (error == null && (value == null || value.isEmpty)) {
      return TextFieldStatus.normal;
    }

    if (error != null) {
      return TextFieldStatus.error;
    }

    return TextFieldStatus.success;
  }
}
