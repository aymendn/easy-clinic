import 'package:client/router/custom_transition.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomGoRoute extends GoRoute {
  CustomGoRoute({
    required super.path,
    super.name,
    required this.page,
    this.popToExitApp = false,
    this.transition = transitionPage,
    super.routes = const <RouteBase>[],
  }) : super(
          pageBuilder: (context, state) {
            return transitionPage(
              context: context,
              state: state,
              child: page,
            );
          },
        );
  final Widget page;
  final bool popToExitApp;
  final CustomTransitionPage Function({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) transition;
}
