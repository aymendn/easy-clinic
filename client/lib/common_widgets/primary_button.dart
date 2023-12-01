import 'package:client/common_widgets/custom_loading.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum IconPosition { start, end }

class PrimaryButton extends StatelessWidget {
  factory PrimaryButton.outlined({
    required VoidCallback onPressed,
    String? text,
    Widget? child,
    IconPosition iconPosition = IconPosition.start,
    IconData? icon,
    Widget? widgetIcon,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    Color? strokeColor,
    double? strokeWeight,
    double? width,
    double? height,
    MainAxisSize rowMainAxisSize = MainAxisSize.max,
    bool isLoading = false,
    EdgeInsetsGeometry? padding,
  }) {
    return PrimaryButton(
      onPressed: onPressed,
      text: text,
      iconPosition: iconPosition,
      icon: icon,
      widgetIcon: widgetIcon,
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      strokeColor: strokeColor,
      strokeWeight: strokeWeight,
      width: width,
      height: height,
      isOutlined: true,
      rowMainAxisSize: rowMainAxisSize,
      isLoading: isLoading,
      padding: padding,
      child: child,
    );
  }

  // text button factory
  factory PrimaryButton.text({
    required VoidCallback onPressed,
    required String text,
    IconPosition iconPosition = IconPosition.start,
    IconData? icon,
    Widget? widgetIcon,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    double? width,
    double? height,
    MainAxisSize rowMainAxisSize = MainAxisSize.max,
    bool isLoading = false,
    EdgeInsetsGeometry? padding,
  }) {
    return PrimaryButton(
      onPressed: onPressed,
      text: text,
      iconPosition: iconPosition,
      icon: icon,
      widgetIcon: widgetIcon,
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      width: width,
      height: height,
      isOutlined: true,
      rowMainAxisSize: rowMainAxisSize,
      isLoading: isLoading,
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 18.wm, vertical: 12.hm),
      strokeColor: Colors.transparent,
      strokeWeight: 0,
    );
  }
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.iconPosition = IconPosition.start,
    this.icon,
    this.widgetIcon,
    this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.strokeColor,
    this.strokeWeight,
    this.height,
    this.width,
    this.textStyle,
    this.isOutlined = false,
    this.rowMainAxisSize = MainAxisSize.max,
    this.isLoading = false,
    this.padding,
  });

  final IconPosition iconPosition;
  final VoidCallback? onPressed;
  final String? text;
  final IconData? icon;
  final Widget? widgetIcon;
  final Widget? child;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? strokeColor;
  final double? strokeWeight;
  final double? width;
  final double? height;
  final bool isOutlined;
  final MainAxisSize rowMainAxisSize;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    // you either provide one of the following:
    // - child only
    // - text only
    // - text and icon
    // - text and iconWidget

    assert(child != null || text != null);

    final textWidget = text == null ? null : Text(text!);
    final iconWidget = widgetIcon ?? (icon == null ? null : Icon(icon));

    Widget childWidget() {
      if (isLoading) {
        return CustomLoading(
          color: context.colorScheme.surface,
        );
      }

      if (child != null) {
        return child!;
      }

      if (iconWidget == null) {
        return textWidget!;
      }

      List<Widget> children = [
        iconWidget,
        8.gapW,
        textWidget!,
      ];

      if (iconPosition == IconPosition.end) {
        children = children.reversed.toList();
      }

      // TODO: fix overflow
      final row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: rowMainAxisSize,
        children: children,
      );

      return row;
    }

    final minimumSize = Size(width ?? 0, height ?? 0);
    final padding = this.padding ??
        EdgeInsets.symmetric(horizontal: 24.wm, vertical: 16.hm);
    final side = strokeColor == null
        ? null
        : BorderSide(
            color: strokeColor!,
            width: strokeWeight ?? 1,
          );

    VoidCallback? onTap = onPressed == null
        ? null
        : () {
            onPressed!();
            HapticFeedback.lightImpact();
          };

    if (isOutlined) {
      return OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          disabledForegroundColor: disabledForegroundColor,
          minimumSize: minimumSize,
          padding: padding,
          side: side,
          textStyle: textStyle,
        ),
        child: childWidget(),
      );
    } else {
      return FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          disabledForegroundColor: disabledForegroundColor,
          minimumSize: minimumSize,
          padding: padding,
          side: side,
          textStyle: textStyle,
        ),
        child: childWidget(),
      );
    }
  }
}
