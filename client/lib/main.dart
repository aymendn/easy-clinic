// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:client/app.dart';
import 'package:client/providers/prefs.dart';
import 'package:client/utils/prefs.dart';
import 'package:client/web_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

// * Set this to false to run the app in desktop mode
// ============================
const LAUNCH_MODE_WEB = false;
// ============================

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await Prefs.init();

  // * Make GoRouter's push and pop methods work on web urls
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // * turn off the # in the URLs on the web
  usePathUrlStrategy();

  // * Register error handlers. For more info, see:
  // * https://docs.flutter.dev/testing/errors
  registerErrorHandlers();

  // * Run the app
  runApp(
    ProviderScope(
      overrides: [
        prefsProvider.overrideWithValue(prefs),
      ],
      child: ScreenUtilInit(
        designSize: const Size(1280, 720),
        builder: (_, __) => LAUNCH_MODE_WEB ? const WebApp() : const App(),
      ),
    ),
  );
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            Center(
              child: Text(
                details.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  };
}
