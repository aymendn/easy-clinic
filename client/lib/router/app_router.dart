import 'dart:async';

import 'package:client/debug/logger.dart';
import 'package:client/features/home/home_screen.dart';
import 'package:client/features/login/presentation/login_screen.dart';
import 'package:client/features/playground.dart';
import 'package:client/router/custom_go_route.dart';
import 'package:client/router/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  login, patients, appointments, playground,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final List<RouteBase> routes = [
    CustomGoRoute(
      path: '/home',
      name: AppRoute.home.name,
      page: const HomeScreen(),
    ),
    CustomGoRoute(
      path: '/login',
      name: AppRoute.login.name,
      page: const LoginScreen(),

    ),
    // playground
    CustomGoRoute(
      path: '/playground',
      name: AppRoute.playground.name,
      page: const PlaygoundScreen(),
    ),

  ];

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    logger.fine('redirect: ${state.fullPath}');

    return null;
  }

  return GoRouter(
    initialLocation: '/playground',
    routes: routes,
    redirect: redirect,
    errorBuilder: (_, __) => const ErrorScreen(),
  );
});
