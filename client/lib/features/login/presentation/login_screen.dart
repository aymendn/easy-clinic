import 'package:client/assets/assets.gen.dart';
import 'package:client/common_widgets/form/custom_text_form_field.dart';
import 'package:client/common_widgets/form/form_column.dart';
import 'package:client/common_widgets/primary_button.dart';
import 'package:client/common_widgets/svg_icon.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:client/features/login/presentation/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(loginControllerProvider);
    final notifier = ref.read(loginControllerProvider.notifier);

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final email = useTextEditingController();
    final password = useTextEditingController();

    Future<void> onSubmit() async {
      if (!formKey.currentState!.validate()) return;
      notifier.login(context);
    }

    return Scaffold(
      body: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 560.wm,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 40.h),
              child: FormColumn(
                formKey: formKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgIcon(
                    Assets.logo.logoSvg.path,
                    size: 80.rm,
                    color: context.colors.primary,
                  ),
                  24.gapH,
                  Text(
                    'Welcome Back!',
                    style: context.textTheme.titleLarge,
                  ),
                  4.gapH,
                  Text(
                    'Sign in to continue',
                    style: context.textTheme.labelMedium,
                  ),
                  24.gapH,
                  CustomTextFormField(
                    controller: email,
                    label: 'Email',
                    hint: 'Enter your emal',
                    prefixIconPath: Assets.icons.email.path,
                  ),
                  24.gapH,
                  CustomTextFormField(
                    controller: password,
                    label: 'Password',
                    hint: 'Enter your password',
                    obscureText: true,
                    prefixIconPath: Assets.icons.password.path,
                  ),
                  24.gapH,
                  PrimaryButton(
                    isLoading: controller.isLoading,
                    width: double.infinity,
                    height: 70.hm,
                    onPressed: onSubmit,
                    text: 'Sign In',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Assets.images.patternBackground.image(
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
