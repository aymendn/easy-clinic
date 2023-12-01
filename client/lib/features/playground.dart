import 'package:client/common_widgets/logo_loading.dart';
import 'package:flutter/material.dart';

class PlaygoundScreen extends StatelessWidget {
  const PlaygoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playground'),
      ),
      body: Center(
        child: LogoLoading(),
      ),
    );
  }
}
