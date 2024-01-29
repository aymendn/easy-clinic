import 'package:client/common_widgets/custom_loading.dart';
import 'package:client/common_widgets/primary_button.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:client/extensions/screen_utils_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AsyncValueBuilder<T> extends StatelessWidget {
  const AsyncValueBuilder({
    super.key,
    required this.value,
    required this.data,
    this.fakeValue,
    this.error,
    this.loading,
    this.foregroundColor,
    this.backgroundColor,
    this.onRefresh,
    this.showLoadingOnError = false,
    this.skeletonizerIgnorePointers = true,
    this.loadingOpacity = 0.2,
  });

  final AsyncValue<T> value;
  final T? fakeValue;
  final Widget Function(T value) data;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget Function()? loading;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final VoidCallback? onRefresh;
  final bool showLoadingOnError;
  final bool skeletonizerIgnorePointers;
  final double loadingOpacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: 300.milliseconds,
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: value.when(
        data: data,
        loading: loadingBuilder,
        error: (e, st) => errorBuilder(e, st, context),
      ),
    );
  }

  Widget loadingBuilder() {
    if (fakeValue != null) {
      return Skeletonizer(
        ignorePointers: skeletonizerIgnorePointers,
        child: data(fakeValue as T),
      );
    }

    if (loading != null) {
      return loading!();
    }

    return Center(
      child: CustomLoading(
        size: 30.rm,
        strokeWidth: 3,
        color: foregroundColor,
      ),
    );
  }

  Widget errorBuilder(Object e, StackTrace st, BuildContext context) {
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "An error occurred",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: (foregroundColor ?? context.colors.textPrimary)
                .withOpacity(0.7),
          ),
        ),
        if (onRefresh != null)
          PrimaryButton.text(
            rowMainAxisSize: MainAxisSize.min,
            icon: Icons.refresh_rounded,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            onPressed: onRefresh!,
            text: "Refresh",
          ),
      ],
    );

    if (showLoadingOnError) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: loadingOpacity,
            child: loadingBuilder(),
          ),
          errorBuilder(e, st, context),
        ],
      );
    }

    return errorBuilder(e, st, context);
  }
}
