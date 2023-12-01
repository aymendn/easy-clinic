import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PlaygroundScreen extends HookWidget {
  const PlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentSliderValue = useState(20.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playground'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Playground'),
            Slider(
              value: currentSliderValue.value,
              min: 0,
              max: 100,
              divisions: 5,
              label: currentSliderValue.value.round().toString(),
              onChanged: (double value) {
                currentSliderValue.value = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
