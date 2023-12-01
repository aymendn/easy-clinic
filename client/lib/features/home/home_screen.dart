import 'package:client/common_widgets/rounded_page_view.dart';
import 'package:client/extensions/color_extensions.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/features/home/domain/drawer_item_model.dart';
import 'package:client/features/home/presentation/logo_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Maximize window after 500ms
    useEffect(() {
      Future.delayed(
        500.ms,
        () => WindowManager.instance.maximize(),
      );
      return null;
    }, []);

    final index = useState(0);

    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h)
                .copyWith(right: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: NavigationDrawer(
                onDestinationSelected: (value) => index.value = value,
                selectedIndex: index.value,
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
                ],
              ),
            ),
          ),
          Expanded(
            child: RoundedPageView(
                child: Center(
              child: Text(
                DrawerItemModel.items[index.value].title,
                style: context.textTheme.titleLarge,
              ),
            )),
          ),
        ],
      ),
    );
  }
}
