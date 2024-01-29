import 'package:client/assets/assets.gen.dart';
import 'package:client/common_widgets/form/custom_text_form_field.dart';
import 'package:client/common_widgets/primary_button.dart';
import 'package:client/common_widgets/svg_icon.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:client/features/web/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebScreen extends HookConsumerWidget {
  const WebScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(webControllerProvider);
    final notifier = ref.read(webControllerProvider.notifier);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final name = useTextEditingController();
    final email = useTextEditingController();
    final phoneNumber = useTextEditingController();
    final message = useTextEditingController();
    final status = useTextEditingController();

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;
      await notifier.submit(
        name: name.text,
        email: email.text,
        phoneNumber: phoneNumber.text,
        message: message.text,
        status: status.text,
        context: context,
      );
    }

    return Scaffold(
      body: Form(
        key: formKey,
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 60),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 340.wm),
                child: Column(
                  children: [
                    const _Logo(),
                    18.gapH,
                    const Text(
                      'Fill the form to request an appointment.',
                      textAlign: TextAlign.center,
                    ),
                    20.gapH,
                    CustomTextFormField(
                      label: 'Name',
                      controller: name,
                      hint: 'Enter your name',
                      isRequired: true,
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 12),
                        child: Icon(
                          Icons.person_outline,
                          color: context.colors.strokeDarker,
                        ),
                      ),
                    ),
                    20.gapH,
                    CustomTextFormField(
                      label: 'Email',
                      controller: email,
                      hint: 'Enter your email',
                      isRequired: true,
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 12),
                        child: Icon(
                          Icons.email_outlined,
                          color: context.colors.strokeDarker,
                        ),
                      ),
                    ),
                    20.gapH,
                    CustomTextFormField(
                      label: 'Phone Number',
                      controller: phoneNumber,
                      hint: 'Enter your phone number',
                      isRequired: true,
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 12),
                        child: Icon(
                          Icons.phone_outlined,
                          color: context.colors.strokeDarker,
                        ),
                      ),
                    ),
                    20.gapH,
                    CustomTextFormField(
                      label: 'Status',
                      controller: status,
                      hint: 'Enter your status',
                      isRequired: true,
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 12),
                        child: Icon(
                          Icons.list_alt_outlined,
                          color: context.colors.strokeDarker,
                        ),
                      ),
                    ),
                    20.gapH,
                    CustomTextFormField(
                      label: 'Message',
                      controller: message,
                      hint: 'Explain your problem in detail...',
                      maxLines: 4,
                      minLines: 2,
                      isRequired: true,
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 12),
                        child: Icon(
                          Icons.message_outlined,
                          color: context.colors.strokeDarker,
                        ),
                      ),
                    ),
                    20.gapH,
                    PrimaryButton(
                      onPressed: submit,
                      isLoading: controller is AsyncLoading,
                      text: 'Submit',
                      icon: Icons.send_outlined,
                      iconPosition: IconPosition.end,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 26,
                        horizontal: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgIcon(
          Assets.logo.logoSvg.path,
          color: context.colors.primary,
          size: 80.rm,
        ),
        16.gapH,
        Text(
          'EasyClinic',
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colors.primary,
            fontSize: 34.spMin,
            fontWeight: FontWeight.w600,
            letterSpacing: -1.2.spMin,
          ),
        ),
      ],
    );
  }
}
