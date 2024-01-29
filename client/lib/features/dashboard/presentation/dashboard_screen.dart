import 'package:client/common_widgets/async_value_builder.dart';
import 'package:client/common_widgets/home_card.dart';
import 'package:client/features/dashboard/domain/dashboard_data.dart';
import 'package:client/features/dashboard/presentation/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(dashboardControllerProvider);

    return AsyncValueBuilder(
      value: controller,
      fakeValue: DashboardData.dashboardData,
      data: (value) {
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1.2,
            mainAxisExtent: 280,
          ),
          itemCount: DashboardData.dashboardData.length,
          itemBuilder: (BuildContext context, int index) {
            final data = DashboardData.dashboardData[index];
            return HomeCard(
              title: data.title,
              subtitle: data.subtitle,
              count: 1,
              icon: data.icon,
              color: data.color,
              index: data.index,
            );
          },
        );
      },
    );
  }
}
