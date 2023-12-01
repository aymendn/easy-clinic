import 'package:flutter/material.dart';

class ScrollableColumn extends StatelessWidget {
  const ScrollableColumn({
    super.key,
    this.padding,
    this.formKey,
    required this.children,
    this.onWillPop,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final EdgeInsets? padding;
  final List<Widget> children;
  final GlobalKey<FormState>? formKey;
  final Future<bool> Function()? onWillPop;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    Widget widget = SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          ),
        ),
      ),
    );

    if (formKey != null) {
      widget = Form(key: formKey, child: widget);
    }

    if (onWillPop != null) {
      widget = WillPopScope(onWillPop: onWillPop, child: widget);
    }

    return widget;
  }
}
