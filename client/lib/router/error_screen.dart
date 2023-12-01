import 'package:client/common_widgets/primary_button.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:client/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Page non trouvée',
              style: context.textTheme.titleLarge,
            ),
            4.gapH,
            const Text('La page que vous cherchez n\'existe pas.'),
            16.gapH,
            PrimaryButton(
              onPressed: () => context.goNamed(AppRoute.login.name),
              text: 'Retour à l\'accueil',
            ),
          ],
        ),
      ),
    );
  }
}
