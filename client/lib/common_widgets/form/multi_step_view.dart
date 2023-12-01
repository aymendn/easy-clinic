import 'package:animations/animations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MultiStepView extends StatelessWidget {
  const MultiStepView({
    super.key,
    required this.index,
    required this.views,
    this.onBackButtonPressed,
    this.layoutBuilder,
  });

  final MultiStepIndex index;
  final List<Widget> views;
  final bool Function()? onBackButtonPressed;
  final Widget Function(List<Widget>)? layoutBuilder;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return onBackButtonPressed?.call() ?? true;
      },
      child: PageTransitionSwitcher(
        reverse: index.isReverse,
        layoutBuilder: layoutBuilder ??
            (List<Widget> entries) {
              return AnimatedSize(
                duration: 150.ms,
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                curve: Curves.easeInOut,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: entries,
                ),
              );
            },
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
        child: index.currentView(views),
      ),
    );
  }
}

///
class MultiStepIndex extends Equatable {

  // init to 0
  const MultiStepIndex({
    this.currentIndex = 0,
    this.isReverse = false,
  });
  final int currentIndex;
  final bool isReverse;

  MultiStepIndex copyWith({
    int? currentIndex,
    bool? isReverse,
  }) {
    return MultiStepIndex(
      currentIndex: currentIndex ?? this.currentIndex,
      isReverse: isReverse ?? this.isReverse,
    );
  }

  Widget currentView(List<Widget> views) => views[currentIndex];
  double progress(int length) => (currentIndex + 1) / length;
  double realProgress(int length) => currentIndex / length;
  bool canNext(int length) => currentIndex < length - 1;
  bool canPrevious(int length) => currentIndex > 0;

  MultiStepIndex get next =>
      copyWith(currentIndex: currentIndex + 1, isReverse: false);

  MultiStepIndex get previous =>
      copyWith(currentIndex: currentIndex - 1, isReverse: true);

  MultiStepIndex set(int index) {
    return copyWith(
      currentIndex: index,
      isReverse: currentIndex > index,
    );
  }

  set value(int val) {}

  @override
  List<Object?> get props => [currentIndex, isReverse];
}

ValueNotifier<MultiStepIndex> useMultiStepIndex() {
  return useState(const MultiStepIndex());
}

extension MultiStepIndexStateExt on ValueNotifier<MultiStepIndex> {
  int get currentIndex => value.currentIndex;
  bool get isReverse => value.isReverse;
  Widget currentView(List<Widget> views) => value.currentView(views);
  double progress(int length) => value.progress(length);
  double realProgress(int length) => value.realProgress(length);
  bool canNext(int length) => currentIndex < length - 1;
  bool canPrevious(int length) => currentIndex > 0;
  set currentIndex(int val) => value = value.set(val);
  void next() {
    value = value.next;
  }

  void previous() {
    value = value.previous;
  }
}
