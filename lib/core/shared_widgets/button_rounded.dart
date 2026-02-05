import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';

class MyRoundedButton extends StatelessWidget {
  const MyRoundedButton({
    super.key,
    required this.label,
    this.labelColor,
    required this.onPressed,
    this.fillColor,
    this.enableShadow = false,
    this.enableBorder = false,
    this.labelSize,
    this.isDisabled = false,
  });

  final Color? labelColor;
  final Color? fillColor;
  final String label;
  final bool enableShadow;
  final bool enableBorder;
  final num? labelSize;
  final bool isDisabled;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        decoration: BoxDecoration(
          color: isDisabled ? kLightGreyColor : fillColor,
          borderRadius: BorderRadius.circular(50),
          border: enableBorder ? Border.all(color: kPrimaryColor, width: 1) : null,
          boxShadow: enableShadow
              ? const [
                  BoxShadow(
                    blurRadius: 6,
                    spreadRadius: 1,
                    color: kGreyColor,
                    offset: Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isDisabled ? kGreyColor : labelColor ?? kSecondaryColor,
              fontSize: labelSize?.toDouble() ?? 12,
            ),
          ),
        ),
      ),
    );
  }
}

class MyCircularButton extends StatelessWidget {
  const MyCircularButton({
    super.key,
    required this.child,
    this.labelColor,
    required this.onPressed,
    this.fillColor,
    this.enableShadow = false,
    this.height,
    this.width,
    this.isDisabled = false,
  });

  final Color? labelColor;
  final Color? fillColor;
  final Widget child;
  final bool enableShadow;
  final num? height;
  final num? width;
  final VoidCallback onPressed;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        height: height?.toDouble() ?? 70,
        width: width?.toDouble() ?? 70,
        decoration: BoxDecoration(
          color: isDisabled ? kLightGreyColor : fillColor,
          shape: BoxShape.circle,
        ),
        child: Center(child: child),
      ),
    );
  }
}

class MySmallButton extends StatelessWidget {
  const MySmallButton({
    super.key,
    required this.isSelected,
    this.onTap,
    this.title,
    this.internalPadding,
    this.isSecondary = false,
    this.secondaryColor = kPrimaryColor,
    this.isEnabled = true,
  });
  final bool isSelected;
  final VoidCallback? onTap;
  final String? title;
  final EdgeInsets? internalPadding;
  final bool isSecondary;
  final Color? secondaryColor;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return
    // Add/Remove Button
    GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        padding: internalPadding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: !isEnabled
              ? kMutedTextColor.withAlpha(opacityToAlpha(0.1))
              : (isSecondary ? kWhiteColor : null),
          gradient: !isEnabled
              ? null
              : (isSecondary
                    ? null
                    : (isSelected
                          ? LinearGradient(
                              colors: [kRedColor, kRedColor.withAlpha(opacityToAlpha(0.8))],
                            )
                          : kMainGradient)),
          borderRadius: BorderRadius.circular(10),
          border: !isEnabled
              ? Border.all(color: kMutedTextColor.withAlpha(opacityToAlpha(0.3)), width: 1)
              : (isSecondary ? Border.all(color: secondaryColor!, width: 1) : null),
          boxShadow: !isEnabled
              ? []
              : [
                  BoxShadow(
                    color: isSecondary
                        ? secondaryColor!.withAlpha(opacityToAlpha(0.1))
                        : (isSelected ? kRedColor : kPrimaryColor).withAlpha(opacityToAlpha(0.3)),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title == null) ...[
              Icon(
                isSelected ? Icons.delete_outline : Icons.add,
                color: !isEnabled
                    ? kMutedTextColor.withAlpha(opacityToAlpha(0.5))
                    : (isSecondary ? secondaryColor : kWhiteColor),
                size: 18,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              title ?? (isSelected ? remove.tr : add.tr),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: !isEnabled
                    ? kMutedTextColor.withAlpha(opacityToAlpha(0.5))
                    : (isSecondary ? secondaryColor : kWhiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCategoryButton extends StatelessWidget {
  const MyCategoryButton({
    super.key,
    required this.onTap,
    required this.assetPath,
    required this.title,
    this.borderColor,
  });

  final VoidCallback onTap;
  final String assetPath;
  final String title;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 120,
        // height: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor ?? kPrimaryColor.withAlpha(opacityToAlpha(1)),
            width: 1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Image.asset(assetPath, height: 35), const VPadding(6), Text(title)],
          ),
        ),
      ),
    );
  }
}
