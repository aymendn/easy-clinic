import 'package:client/assets/assets.gen.dart';
import 'package:client/common_widgets/form/custom_suffix_icon.dart';
import 'package:client/common_widgets/form/text_field_status.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:client/utils/validators.dart';
import 'package:client/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomTextFormField extends HookWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    required this.label,
    this.validator,
    this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.prefixIconPath,
    this.errorText,
    this.inputFormatters,
    this.prefix,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.isRequired = true,
  });

  final TextEditingController? controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? prefixIconPath;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final VoidCallback? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final isShowPassword = useState(false);
    final isMultiline = maxLines != 1;
    final bRadius = isMultiline ? 20.rm : null;

    Widget? suffixPasswordIcon = obscureText
        ? CustomSuffixIcon(
            iconPath: isShowPassword.value
                ? Assets.icons.eye.path
                : Assets.icons.eyeOff.path,
            onTap: () => isShowPassword.value = !isShowPassword.value,
          )
        : null;

    final error = useState<String?>(errorText);
    final currentValue = useState<String?>(controller?.text);

    final currentStatus = TextFieldStatus.getStatusFromValueAndError(
      currentValue.value,
      error.value,
    );
    Color strokeColor = currentStatus.color(context);
    Widget? statusIcon = currentStatus.statusIcon();

    Widget? prefixIcon = WidgetUtils.fieldPrefix(
      context: context,
      prefixIconPath: prefixIconPath,
      prefix: prefix,
    );

    Widget? suffixWidget = WidgetUtils.fieldSuffix(
      statusIcon: statusIcon,
      suffixPasswordIcon: suffixPasswordIcon,
      suffixHelpIcon: null,
    );

    final validator = isRequired
        ? Validators.mergeWithRequired(this.validator)
        : this.validator;

    final label = isRequired ? '${this.label} *' : this.label;

    return TextFormField(
      controller: controller,
      validator: validator,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      readOnly: readOnly,
      style: context.textTheme.bodyMedium,
      obscureText: obscureText && !isShowPassword.value,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onChanged: (value) {
        onChanged?.call(value);
        currentValue.value = value;
        if (validator != null) {
          error.value = validator(value);
        }
      },
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        errorText: errorText ?? error.value,
        labelText: label,
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 25.wm,
          vertical: 22.hm,
        ),
        suffixIcon: suffixWidget,
        prefixIcon: prefixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        alignLabelWithHint: true,
        border: WidgetUtils.border(strokeColor, null, bRadius),
        errorBorder: WidgetUtils.border(context.colors.error, null, bRadius),
        enabledBorder: WidgetUtils.border(strokeColor, null, bRadius),
        focusedBorder: WidgetUtils.border(strokeColor, 2, bRadius),
        focusedErrorBorder:
            WidgetUtils.border(context.colors.error, 2, bRadius),
        disabledBorder:
            WidgetUtils.border(strokeColor.withOpacity(.4), null, bRadius),
      ),
    );
  }
}
