import 'package:animations/animations.dart';
import 'package:client/common_widgets/custom_dialog.dart';
import 'package:client/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  AppColors get colors => AppColors.light;
  ColorScheme get colorScheme => theme.colorScheme;
  NavigatorState get navigator => Navigator.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  TextTheme get textTheme => theme.textTheme;
  Size get size => mediaQuery.size;
  double get height => size.height;
  double get width => size.width;
  TextDirection get direction => Directionality.of(this);
  bool get isRtl => direction == TextDirection.rtl;
  bool get isLtr => direction == TextDirection.ltr;
  FocusScopeNode get focusScope => FocusScope.of(this);
  Locale get locale => Localizations.localeOf(this);
  String get localeLanguageCode => locale.languageCode;



  // dialog
  Future<T?> customWidgetDialog<T>(
    Widget child, {
    bool barrierDismissible = true,
  }) {
    return showModal<T>(
      context: this,
      builder: (context) => child,
      configuration: FadeScaleTransitionConfiguration(
        transitionDuration: 300.ms,
        reverseTransitionDuration: 200.ms,
        barrierDismissible: barrierDismissible,
      ),
    );
  }


  Future<T?> customDialog<T>({
    String? title,
    required String content,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    return showModal<T>(
      context: this,
      configuration: FadeScaleTransitionConfiguration(
        transitionDuration: 300.ms,
        reverseTransitionDuration: 200.ms,
        barrierDismissible: barrierDismissible,
      ),
      builder: (context) {
        return CustomDialog(
          title: title,
          content: content,
          actions: actions,
        );
      },
    );
  }
}
