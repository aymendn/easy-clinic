import 'package:client/common_widgets/primary_button.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  // dialog
  void dialog(Widget child, {bool barrierDismissible = true}) {
    showDialog(
      context: this,
      builder: (context) => child,
      barrierDismissible: barrierDismissible,
    );
  }

  // push, pop
  void push(Widget child) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => child),
    );
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  Future futureDialog(Widget child) async {
    return await showDialog(
      context: this,
      builder: (context) => child,
      barrierDismissible: true,
    );
  }


  Future<bool> confirmDialog(
    String text, {
    String? remark,
    String? actionString,
    String? okText,
    String? cancelText,
  }) async {
    if (!mounted) return false;
    final restult = await showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        content: Container(
          constraints: const BoxConstraints(minWidth: 500, maxWidth: 500),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text),
              const SizedBox(height: 10),
              if (remark != null)
                Text(
                  remark,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        actions: [
          PrimaryButton(
            text: okText ?? "OK",
            onPressed: () => Navigator.of(context).pop(true),
          ),
          PrimaryButton.outlined(
            text: cancelText ?? "Cancel",
            onPressed: () => Navigator.of(context).pop(false),
          ),
          if (remark != null && actionString != null)
            PrimaryButton.outlined(
              text: actionString,
              onPressed: () => Navigator.of(context).pop(true),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
        ],
      ),
      barrierDismissible: false,
    );

    return restult ?? false;
  }
}
