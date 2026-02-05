import 'package:flutter/material.dart';
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
