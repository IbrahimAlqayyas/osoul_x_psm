import 'package:flutter/material.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';

class MyProgressIndicator extends StatelessWidget {
  final double? size;
  final bool useIcon;
  final bool enableRotation;
  final bool enableShine;
  final Duration? animationDuration;

  const MyProgressIndicator({
    super.key,
    this.size,
    this.useIcon = true,
    this.enableRotation = false,
    this.enableShine = true,
    this.animationDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size ?? 30,
        width: size ?? 30,
        child: const CircularProgressIndicator(color: kSecondaryColor),
      ),
    );
    // return AnimatedLogoLoadingIndicator(
    //   size: size,
    //   useIcon: useIcon,
    //   enableRotation: enableRotation,
    //   enableShine: enableShine,
    //   animationDuration: animationDuration,
    // );
  }
}

/// Predefined loading indicator variants for common use cases
class LoadingIndicators {
  /// Default loading indicator with shine effect (like splash screen)
  static const Widget shine = MyProgressIndicator(enableShine: true, enableRotation: false);

  /// Loading indicator with rotation effect (like old version)
  static const Widget rotating = MyProgressIndicator(enableShine: false, enableRotation: true);

  /// Loading indicator with both shine and rotation effects
  static const Widget shineAndRotate = MyProgressIndicator(enableShine: true, enableRotation: true);

  /// Large loading indicator with shine effect for prominent displays
  static const Widget largeLogo = MyProgressIndicator(
    size: 60,
    useIcon: false,
    enableShine: true,
    enableRotation: false,
  );

  /// Small loading indicator for tight spaces
  static const Widget small = MyProgressIndicator(
    size: 20,
    enableShine: true,
    enableRotation: false,
  );
}
