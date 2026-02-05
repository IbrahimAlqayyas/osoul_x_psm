import 'package:flutter/material.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_gradient.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';
import '../../main.dart';
import '../localization/01_translation_keys.dart';
import '../localization/03_supported_locales.dart';
import 'padding.dart';
import 'package:get/get.dart';

Future showSuccessDialog({String? title, String? description, VoidCallback? okFunction}) {
  return Get.dialog(
    PopupWidget(
      title: title ?? operationSucceeded.tr,
      imageAsset: 'assets/images/success.png',
      subtitle: description,
      onConfirm: okFunction,
      isSuccess: true,
    ),
    barrierDismissible: true,
    barrierColor: Colors.black.withAlpha(opacityToAlpha(0.6)),
  );
}

Future showFailureDialog({
  String? title,
  String? description,
  VoidCallback? okFunction,
  bool showOkButton = true,
  bool isDismissible = true,
  bool canPop = true,
}) {
  return Get.dialog(
    PopScope(
      canPop: canPop,
      child: PopupWidget(
        title: title ?? operationFailed.tr,
        imageAsset: 'assets/images/failure.png',
        subtitle: description,
        onConfirm: okFunction,
        showOkButton: showOkButton,
        isSuccess: false,
      ),
    ),
    barrierDismissible: isDismissible,
    barrierColor: Colors.black.withAlpha(opacityToAlpha(0.6)),
  );
}

Future showConfirmDialog({
  String? title,
  String? description,
  required VoidCallback confirmFunction,
}) {
  return Get.dialog(
    ConfirmPopupWidget(
      confirmFunction: confirmFunction,
      popupContent: Material(
        color: kTransparent,
        child: Column(
          children: [
            const VPadding(20),
            if (description == null)
              SizedBox(
                width: Get.width - 150,
                child: Center(
                  child: Text(
                    title ?? areYouSure.tr,
                    style: const TextStyle(
                      color: kBlackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (description != null)
              SizedBox(
                width: Get.width - 150,
                child: Center(
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kBlackColor.withAlpha(opacityToAlpha(0.7)),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            const VPadding(20),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
    barrierColor: Colors.black.withAlpha(opacityToAlpha(0.6)),
  );
}

/// Generic dialog that can display any widget with app styling
Future<dynamic> showMyDialog(
  Widget child, {
  bool isDismissible = true,
  num? width,
  num? height,
  bool applyPadding = true,
}) {
  return Get.dialog(
    DialogWidget(height: height, width: width, applyPadding: applyPadding, child: child),
    barrierDismissible: isDismissible,
    barrierColor: Colors.black.withAlpha(opacityToAlpha(0.6)),
  );
}

Future<dynamic> showMyBottomSheet(
  Widget child, {
  double? height,
  bool isScrollControlled = true,
  bool applyPadding = true,
  bool isRounded = true,
  bool enableTitle = false,
  String backTitle = '',
  double backgroundOpacity = 1,
  Function()? onClose,
  Function(dynamic)? onSave,
  bool enableDragLine = false,
  bool enableCloseButton = false,
}) {
  return Get.bottomSheet(
    SheetWidget(
      height: height,
      enableCloseButton: enableCloseButton,
      onClose: onClose,
      enableTitle: enableTitle,
      backTitle: backTitle,
      enableDragLine: enableDragLine,
      applyPadding: applyPadding,
      child: child,
    ),
    isScrollControlled: true,
    backgroundColor: kTransparent,
    ignoreSafeArea: false,
  ).then((value) {
    if (onSave != null) {
      onSave(value);
    }
    return value;
  });
}

/// Generic Dialog Widget with app styling
class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.applyPadding = true,
  });

  final Widget child;
  final num? width;
  final num? height;
  final bool applyPadding;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: height?.toDouble() ?? 300,
        width: width?.toDouble(),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kPrimaryColor.withAlpha(opacityToAlpha(0.2)), width: 1),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withAlpha(opacityToAlpha(0.15)),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: applyPadding
            ? const EdgeInsets.symmetric(horizontal: 24, vertical: 24)
            : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}

class SheetWidget extends StatelessWidget {
  const SheetWidget({
    super.key,
    required this.child,
    this.height,
    this.enableCloseButton = true,
    this.enableDragLine = true,
    this.onClose,
    this.enableTitle = false,
    this.applyPadding = true,
    this.backTitle = '',
  });

  final Widget child;
  final double? height;
  final bool enableDragLine;
  final bool enableCloseButton;
  final bool enableTitle;
  final bool applyPadding;
  final String backTitle;
  final Function()? onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.only(
        top: 0,
        left: applyPadding ? 16 : 0,
        right: applyPadding ? 16 : 0,
        bottom: applyPadding ? 16 : 0,
      ),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border.all(color: kPrimaryColor.withAlpha(opacityToAlpha(0.1)), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(opacityToAlpha(0.15)),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header
            Stack(
              children: [
                /// Drag line
                if (enableDragLine)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        height: 4,
                        width: 62,
                        decoration: BoxDecoration(
                          gradient: kMainGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                /// Close button
                if (enableCloseButton)
                  Align(
                    alignment: activeLocale == SupportedLocales().english
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: enableTitle
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: applyPadding ? 0 : 16,
                              right: applyPadding ? 0 : 16,
                              top: applyPadding ? 16 : 30,
                              bottom: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  backTitle,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                BottomSheetCloseButton(
                                  onClose: onClose,
                                  applyPadding: !applyPadding,
                                ),
                              ],
                            ),
                          )
                        : BottomSheetCloseButton(onClose: onClose),
                  ),
              ],
            ),
            if (enableDragLine || enableCloseButton) const SizedBox(height: 13),

            /// Child
            child,
          ],
        ),
      ),
    );
  }
}

class BottomSheetCloseButton extends StatelessWidget {
  final bool applyPadding;
  final Function()? onClose;

  const BottomSheetCloseButton({super.key, this.applyPadding = true, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: applyPadding
          ? const EdgeInsets.only(top: 10, left: 10, right: 10)
          : const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onClose ?? () => Get.back(),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: kPrimaryColor.withAlpha(opacityToAlpha(0.1)),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kPrimaryColor.withAlpha(opacityToAlpha(0.3)), width: 1),
          ),
          child: const Icon(Icons.close, color: kPrimaryColor, size: 20),
        ),
      ),
    );
  }
}

class PopupWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String imageAsset;
  final String? confirmText;
  final VoidCallback? onConfirm;
  final bool showOkButton;
  final bool isSuccess;

  const PopupWidget({
    super.key,
    this.title,
    this.subtitle,
    this.imageAsset = 'assets/icons/on_failure.png',
    this.confirmText,
    this.onConfirm,
    this.showOkButton = true,
    this.isSuccess = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSuccess
                ? kGreenColor.withAlpha(opacityToAlpha(0.3))
                : kRedColor.withAlpha(opacityToAlpha(0.3)),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (isSuccess ? kGreenColor : kRedColor).withAlpha(opacityToAlpha(0.2)),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isSuccess
                      ? [
                          kGreenColor.withAlpha(opacityToAlpha(0.2)),
                          kGreenColor.withAlpha(opacityToAlpha(0.1)),
                        ]
                      : [
                          kRedColor.withAlpha(opacityToAlpha(0.2)),
                          kRedColor.withAlpha(opacityToAlpha(0.1)),
                        ],
                ),
                border: Border.all(
                  color: isSuccess
                      ? kGreenColor.withAlpha(opacityToAlpha(0.3))
                      : kRedColor.withAlpha(opacityToAlpha(0.3)),
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  isSuccess ? Icons.check_circle : Icons.error,
                  color: isSuccess ? kGreenColor : kRedColor,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (title != null && title!.trim().isNotEmpty)
              Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isSuccess ? kGreenColor : kRedColor,
                ),
              ),
            if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: kBlackColor.withAlpha(opacityToAlpha(0.7))),
              ),
            ],
            const SizedBox(height: 24),
            if (showOkButton)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: MyGradientButton(
                  label: confirmText ?? (isSuccess ? done.tr : tryAgain.tr),
                  onPressed: onConfirm ?? () => Get.back(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ConfirmPopupWidget extends StatelessWidget {
  final Widget popupContent;
  final double popupHeight;
  final VoidCallback? confirmFunction;

  const ConfirmPopupWidget({
    super.key,
    required this.popupContent,
    this.popupHeight = 350,
    this.confirmFunction,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = (Get.width - 136) / 2;
    final double finalButtonWidth = buttonWidth > 0 ? buttonWidth : 100;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kPrimaryColor.withAlpha(opacityToAlpha(0.2)), width: 1),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withAlpha(opacityToAlpha(0.15)),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    kOrangeColor.withAlpha(opacityToAlpha(0.2)),
                    kOrangeColor.withAlpha(opacityToAlpha(0.1)),
                  ],
                ),
                border: Border.all(color: kOrangeColor.withAlpha(opacityToAlpha(0.3)), width: 2),
              ),
              child: const Center(child: Icon(Icons.help_outline, color: kOrangeColor, size: 32)),
            ),
            popupContent,
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyGradientButton(
                  label: cancel.tr,
                  onPressed: () => Get.back(),
                  isSecondary: true,
                  width: finalButtonWidth,
                ),
                MyGradientButton(
                  label: confirm.tr,
                  onPressed: () {
                    if (confirmFunction != null) {
                      confirmFunction!();
                    }
                  },
                  width: finalButtonWidth,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
