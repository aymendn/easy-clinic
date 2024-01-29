import 'dart:math';

abstract class TimeoutHandler {
  static Future<void> handleTimeout() async {
    final random = Random();
    final randomInt = random.nextInt(1500) + 300;
    await Future.delayed(Duration(milliseconds: randomInt));
  }
}
