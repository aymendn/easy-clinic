import 'package:client/assets/assets.gen.dart';
import 'package:client/common_widgets/form/custom_text_form_field.dart';
import 'package:client/common_widgets/form/form_column.dart';
import 'package:client/common_widgets/primary_button.dart';
import 'package:client/common_widgets/svg_icon.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:client/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

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
                    label: 'Username',
                    hint: 'Enter your username',
                    prefixIconPath: Assets.icons.person.path,
                  ),
                  24.gapH,
                  CustomTextFormField(
                    label: 'Password',
                    hint: 'Enter your password',
                    obscureText: true,
                    prefixIconPath: Assets.icons.password.path,
                  ),
                  24.gapH,
                  PrimaryButton(
                    width: double.infinity,
                    height: 70.hm,
                    onPressed: () => context.goNamed(AppRoute.home.name),
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
