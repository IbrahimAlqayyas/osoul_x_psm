import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/app/environment.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_gradient.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/core/shared_widgets/popups_dialogs.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';

class EnvironmentSelectionDialog extends StatefulWidget {
  const EnvironmentSelectionDialog({super.key, this.onEnvironmentChanged});

  final Function(AppEnvironment)? onEnvironmentChanged;

  @override
  State<EnvironmentSelectionDialog> createState() => _EnvironmentSelectionDialogState();
}

class _EnvironmentSelectionDialogState extends State<EnvironmentSelectionDialog> {
  String selectedEnvironment = 'staging';
  Function(AppEnvironment)? onEnvironmentChanged;

  @override
  void initState() {
    super.initState();
    // Set initial selection based on current environment
    selectedEnvironment = kAppEnvironment is Production ? 'production' : 'staging';
    onEnvironmentChanged = widget.onEnvironmentChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      width: double.infinity,
      child: Column(
        children: [
          // Header
          Text(
            selectEnvironmentTitle.tr,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: kBlackColor),
          ),

          // Content Section
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      color: Colors.white,
      child: Column(
        children: [
          // Message
          Text(
            selectEnvironmentMessage.tr,
            style: TextStyle(fontSize: 14, color: kBlackColor.withAlpha(opacityToAlpha(0.7))),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Environment Options Container
          SizedBox(
            width: double.infinity,
            height: 140,
            child: Column(
              children: [
                // Staging Option
                _buildEnvironmentOption(
                  environmentCode: 'staging',
                  iconData: Icons.science_outlined,
                  environmentName: stagingEnvironmentName.tr,
                  isSelected: selectedEnvironment == 'staging',
                ),

                const SizedBox(height: 12),

                // Production Option
                _buildEnvironmentOption(
                  environmentCode: 'production',
                  iconData: Icons.cloud_done_outlined,
                  environmentName: productionEnvironmentName.tr,
                  isSelected: selectedEnvironment == 'production',
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Confirm Button
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildEnvironmentOption({
    required String environmentCode,
    required IconData iconData,
    required String environmentName,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEnvironment = environmentCode;
        });
      },
      child: Container(
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0ECF4) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF68408C) : const Color(0xFFEFEFEF),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            HPadding(16),
            // Icon
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF68408C).withAlpha(opacityToAlpha(0.1))
                    : const Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Icon(
                iconData,
                size: 20,
                color: isSelected ? const Color(0xFF68408C) : const Color(0xFF70747B),
              ),
            ),

            const SizedBox(width: 16),

            // Environment Name
            Text(
              environmentName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                color: isSelected ? const Color(0xFF002544) : const Color(0xFF2A2F3A),
              ),
            ),

            Spacer(),
            // Check Icon (only show when selected)
            if (isSelected)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 16),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(Icons.check, size: 16, color: const Color(0xFF68408C)),
                ),
              ),
            // Check Icon (only show when selected)
            if (!isSelected) SizedBox(width: 24, height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return MyGradientButton(label: confirm.tr, onPressed: _handleConfirm);
  }

  void _handleConfirm() async {
    // Update the app environment based on selection
    AppEnvironment newEnvironment;
    if (selectedEnvironment == 'production') {
      newEnvironment = Production();
    } else {
      newEnvironment = Staging();
    }

    // Save the environment
    await saveEnvironment(newEnvironment);

    if (onEnvironmentChanged != null) {
      onEnvironmentChanged!(newEnvironment);
    }

    // Close the dialog
    Get.back();
  }
}

// Helper function to show the environment selection dialog
void showEnvironmentSelectionDialog({
  Function(AppEnvironment)? onEnvironmentChanged,
  bool isDismissible = false,
}) {
  showMyDialog(
    EnvironmentSelectionDialog(
      onEnvironmentChanged: (environment) =>
          onEnvironmentChanged != null ? onEnvironmentChanged(environment) : null,
    ),
    height: 400,
    isDismissible: isDismissible,
  );
}
