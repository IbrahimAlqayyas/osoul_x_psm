import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';
import 'package:osoul_x_psm/core/theme/text_styles.dart';

Future<SnackbarController> showSnackBar(
  String message, {
  String? title,
  String? subtitle,
  String? successIconAsset,
  String? failureIconAsset,
  String? warningIconAsset,
  SnackBarType type = SnackBarType.success,
  int duration = 4,
  SnackPosition? position,
  bool hasBorder = false,
}) async {
  return Get.showSnackbar(
    GetSnackBar(
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: Duration(seconds: duration),
      borderRadius: 16,
      borderColor: hasBorder ? kPrimaryColor.withAlpha(opacityToAlpha(0.25)) : null,
      borderWidth: hasBorder ? 1 : null,
      padding: EdgeInsets.zero,
      snackPosition: position ?? SnackPosition.TOP,
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      // onTap: onTap != null ? (_) => onTap() : null,
      messageText: _SnackbarCard(
        title: title,
        subtitle: subtitle ?? message,
        type: type,
        successIconAsset: successIconAsset ?? 'assets/icons/on_success.png',
        failureIconAsset: failureIconAsset ?? 'assets/icons/on_failure.png',
        warningIconAsset: warningIconAsset ?? 'assets/icons/on_warning.png',
      ),
    ),
  );
}

class _SnackbarCard extends StatelessWidget {
  const _SnackbarCard({
    required this.subtitle,
    this.title,
    this.successIconAsset,
    this.failureIconAsset,
    this.warningIconAsset,
    required this.type,
  });

  final String? title;
  final String subtitle;
  final String? successIconAsset;
  final String? failureIconAsset;
  final String? warningIconAsset;
  final SnackBarType type;

  @override
  Widget build(BuildContext context) {
    final Color baseColor = _getBaseColor(type);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(opacityToAlpha(0.08)),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _IconBadge(
                baseColor: baseColor,
                successIconAsset: successIconAsset,
                failureIconAsset: failureIconAsset,
                warningIconAsset: warningIconAsset,
                fallbackType: type,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title != null && title!.trim().isNotEmpty) ...[
                      Text(title!, style: snackbarTitle),
                      const SizedBox(height: 8),
                    ],
                    if (subtitle.trim().isNotEmpty) Text(subtitle, style: snackbarSubtitle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({
    required this.baseColor,
    this.successIconAsset,
    this.failureIconAsset,
    this.warningIconAsset,
    required this.fallbackType,
  });

  final Color baseColor;
  final String? successIconAsset;
  final String? failureIconAsset;
  final String? warningIconAsset;
  final SnackBarType fallbackType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: Center(child: _buildIconWidget()),
    );
  }

  Widget _buildIconWidget() {
    // Priority: specific iconAsset -> type-specific provided -> default fallback icon
    final String? chosenAsset = _typeSpecificAsset();
    if (chosenAsset != null) {
      return Image.asset(chosenAsset, width: 46, height: 46, fit: BoxFit.contain);
    }
    return Icon(_fallbackIcon(fallbackType), color: Colors.white, size: 22);
  }

  String? _typeSpecificAsset() {
    switch (fallbackType) {
      case SnackBarType.success:
        return successIconAsset;
      case SnackBarType.warning:
        return warningIconAsset;
      case SnackBarType.failure:
        return failureIconAsset;
    }
  }

  IconData _fallbackIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check;
      case SnackBarType.warning:
        return Icons.warning_amber_rounded;
      case SnackBarType.failure:
        return Icons.close_rounded;
    }
  }
}

Color _getBaseColor(SnackBarType type) {
  switch (type) {
    case SnackBarType.success:
      return const Color(0xFF4CAF50);
    case SnackBarType.warning:
      return const Color(0xFFFFA726);
    case SnackBarType.failure:
      return const Color(0xFFEF5350);
  }
}

// List<Color> _getGradientColors(SnackBarType type) {
//   // Not used in the new design but kept for backward compatibility if needed elsewhere
//   final Color baseColor = _getBaseColor(type);
//   return [baseColor, baseColor.withAlpha(opacityToAlpha(0.8))];
// }

enum SnackBarType { success, failure, warning }
