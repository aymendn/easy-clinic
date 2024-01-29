import 'package:client/router/app_router.dart';
import 'package:client/utils/timout_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue>((ref) {
  return LoginController();
});

class LoginController extends StateNotifier<AsyncValue> {
  LoginController() : super(const AsyncData(null));

  Future<void> login(BuildContext context) async {
    state = const AsyncLoading();
    await TimeoutHandler.handleTimeout();
    state = const AsyncData(null);
    if (context.mounted) {
      context.goNamed(AppRoute.home.name);
    }
  }
}
