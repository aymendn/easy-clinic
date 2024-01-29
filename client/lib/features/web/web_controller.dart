import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final webControllerProvider = StateNotifierProvider<WebController, AsyncValue>(
  (ref) => WebController(),
);

class WebController extends StateNotifier<AsyncValue> {
  WebController() : super(const AsyncData(null));

  Future<void> submit({
    required String name,
    required String email,
    required String phoneNumber,
    required String message,
    required String status,
    required BuildContext context,
  }) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 2));
    state = const AsyncData(null);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your request has been submitted.'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
