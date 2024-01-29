import 'package:flutter/material.dart';

class NoItems extends StatelessWidget {
  const NoItems({
    super.key,
    this.text = 'No items',
    this.icon = Icons.warning_rounded,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    const color = Color.fromARGB(255, 121, 121, 121);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 36,
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: color,
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}
