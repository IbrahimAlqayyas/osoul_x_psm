import 'package:flutter/material.dart';

class MyAnimatedVisibilitySwitcher extends StatelessWidget {
  final bool show;
  final Widget child;
  final Duration duration;
  final Curve switchInCurve;
  final Curve switchOutCurve;
  final Axis axis;

  /// 🔁 اختياري: لو حبيت تخلي الأنيميشن Slide بدل Fade + Expand
  final bool useSlideTransition;

  /// 🔁 تحديد الاتجاه في حالة Slide
  /// - Offset(1, 0) = من اليمين
  /// - Offset(-1, 0) = من اليسار
  /// - Offset(0, 1) = من الأسفل
  /// - Offset(0, -1) = من الأعلى
  final Offset slideBeginOffset;

  const MyAnimatedVisibilitySwitcher({
    super.key,
    required this.show,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.switchInCurve = Curves.easeOutBack,
    this.switchOutCurve = Curves.easeInBack,
    this.axis = Axis.horizontal,
    this.useSlideTransition = false,
    this.slideBeginOffset = const Offset(1, 0), // من اليمين افتراضيًا
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: (child, animation) {
        if (useSlideTransition) {
          // 🟦 Slide Transition Mode
          final slideAnimation = Tween<Offset>(
            begin: slideBeginOffset,
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: slideAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        } else {
          // 🟩 Fade + Expand Default Mode
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(sizeFactor: animation, axis: axis, child: child),
          );
        }
      },
      child: show ? child : const SizedBox(key: ValueKey('empty_space')),
    );
  }
}
