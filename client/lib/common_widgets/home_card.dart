import 'dart:math';

import 'package:client/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeCard extends ConsumerWidget {
  const HomeCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    this.subtitle,
    this.index,
  });

  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final String? subtitle;
  final int? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    // icon size that depends on both height and width
    final double iconSize = height < 600 || width < 900 ? 60 : 100;

    final double top = min(50, height / 35);
    final double left = min(50, width / 35);

    void changeIndex(int? v) {
      if (v == null ) return;
      ref.read(indexProvider.notifier).state = v;
    }

    return Material(
      child: InkWell(
        onTap: () => changeIndex(index),
        borderRadius: BorderRadius.circular(12),
        mouseCursor: SystemMouseCursors.click,
        splashColor: color.withOpacity(.4),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: color.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(50),
              margin: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FittedBox(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  FittedBox(
                    child: Text(
                      subtitle ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: top,
              right: left,
              child: Icon(
                icon,
                size: iconSize,
                color: color.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
