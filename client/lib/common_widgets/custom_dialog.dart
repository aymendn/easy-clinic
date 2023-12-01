import 'package:client/common_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.title,
    required this.content,
    this.actions,
  });

  final String? title;
  final String content;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!) : null,
      content: Text(content),
      actions: actions ??
          [
            PrimaryButton(
              onPressed: context.pop,
              text: 'OK',
            ),
          ],
    );
  }
}
