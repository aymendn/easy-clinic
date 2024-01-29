import 'package:client/common_widgets/primary_button.dart';
import 'package:client/common_widgets/rounded_page_view.dart';
import 'package:client/extensions/color_extensions.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/features/appointments/presentation/appointments_screen.dart';
import 'package:client/features/dashboard/presentation/dashboard_screen.dart';
import 'package:client/features/home/domain/drawer_item_model.dart';
import 'package:client/features/home/presentation/logo_text.dart';
import 'package:client/features/patients/presentation/patients_screen.dart';
import 'package:client/features/requests/presentation/requests_screen.dart';
import 'package:client/features/users/presentation/users_screen.dart';
import 'package:client/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final indexProvider = StateProvider<int>((ref) {
  return 0;
});

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screens = [
      const DashboardScreen(),
      const RequestsScreen(),
      const PatientsScreen(),
      const AppointmentsScreen(),
      const UsersScreen(),
    ];

    final index = ref.watch(indexProvider);

    return Scaffold(
      body: Row(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 280.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h)
                .copyWith(right: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: NavigationDrawer(
                onDestinationSelected: (v) =>
                    ref.read(indexProvider.notifier).state = v,
                selectedIndex: index,
                surfaceTintColor: Colors.transparent,
                backgroundColor:
                    context.colors.primary.withOpacity(0.06).mergeWithWhite(),
                indicatorColor: context.colors.primary.withOpacity(0.2),
                shadowColor: context.colors.primary.withOpacity(0.2),
                tilePadding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 12.h),
                    child: const LogoText(),
                  ),
                  ...DrawerItemModel.destinations,
                  // logout button
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.w, horizontal: 8.h),
                    child: PrimaryButton(
                      onPressed: () => context.goNamed(AppRoute.login.name),
                      text: "Logout",
                      icon: Icons.logout,
                      backgroundColor: context.colors.error,
                      padding: EdgeInsets.symmetric(
                        vertical: 20.w,
                        horizontal: 12.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RoundedPageView(
              child: Center(
                child: screens[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
