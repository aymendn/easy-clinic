import 'package:client/utils/timout_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, AsyncValue>(
  (ref) => DashboardController(),
);

class DashboardController extends StateNotifier<AsyncValue> {
  DashboardController() : super(const AsyncLoading()) {
    getDashboard();
  }

  Future<void> getDashboard() async {
    state = const AsyncLoading();
    await TimeoutHandler.handleTimeout();
    await Future.delayed(const Duration(seconds: 2));
    state = const AsyncData(null);
  }
}
