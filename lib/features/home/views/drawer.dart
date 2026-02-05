import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/app/version.dart';
import 'package:osoul_x_psm/core/preferences/preferences.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_gradient.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/core/shared_widgets/popups_dialogs.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';
import 'package:osoul_x_psm/features/auth/views/login_view.dart';
import 'package:osoul_x_psm/features/home/controllers/home_controller.dart';
import 'package:osoul_x_psm/features/profile/views/profile_view.dart';
import '../../../../core/localization/01_translation_keys.dart';
import '../../../../core/localization/03_supported_locales.dart';
import '../../../../core/localization/04_localization_service.dart';
import '../../../../main.dart';
import 'package:flutter/cupertino.dart';
import 'package:osoul_x_psm/core/shared_widgets/custom_textfield_widget.dart';
import 'package:osoul_x_psm/features/profile/views/change_password_view.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF002544), Color(0xFF68408C)],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: Align(
                  alignment: activeLocale == SupportedLocales().arabic
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(
                    moreLabel.tr,
                    style: TextStyle(color: kWhiteColor, fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              // Main Content Area
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 14.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Section
                        _buildSection(
                          title: profileTitle.tr,
                          items: [
                            _buildActionItem(
                              icon: Icons.person_outline,
                              title: profileTitle.tr,
                              onTap: () => Get.to(() => const ProfileView()),
                            ),
                          ],
                        ),

                        // const SizedBox(height: 24),
                        // _buildSection(
                        //   title: operationsTitle.tr,
                        //   items: [
                        //     _buildActionItem(
                        //       icon: Icons.local_shipping_outlined,
                        //       title: transferOrdersTitle.tr,
                        //       onTap: () {
                        //         // Get.to(() => const ProfileNewView());
                        //       },
                        //     ),
                        //     _buildActionItem(
                        //       icon: Icons.shopping_cart_outlined,
                        //       title: salesTitle.tr,
                        //       onTap: () {
                        //         // Get.to(() => const ProfileNewView());
                        //       },
                        //     ),
                        //     _buildActionItem(
                        //       icon: Icons.assignment_return_outlined,
                        //       title: inventoryTitle.tr,
                        //       onTap: () {
                        //         // Get.to(() => const ProfileNewView());
                        //       },
                        //     ),
                        //     _buildActionItem(
                        //       icon: Icons.receipt_long_outlined,
                        //       title: returnsTitle.tr,
                        //       onTap: () {
                        //         // Get.to(() => const ReturnCreatedOrdersView());
                        //       },
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 24),

                        // About Section
                        // _buildSection(
                        //   title: aboutTitle.tr,
                        //   items: [
                        //     _buildActionItem(
                        //       icon: Icons.info_outline_rounded,
                        //       title: aboutUsTitle.tr,
                        //       onTap: () {
                        //         // Get.to(
                        //         //   () => AboutUsView(
                        //         //     content: activeLocale == SupportedLocales().english
                        //         //         ? controller.aboutUs?.contentEn ?? 'No Content'
                        //         //         : controller.aboutUs?.contentAr ?? 'No Content',
                        //         //   ),
                        //         // );
                        //       },
                        //     ),
                        //     _buildActionItem(
                        //       icon: Icons.description_outlined,
                        //       title: termsAndConditionsTitle.tr,
                        //       onTap: () {
                        //         // Get.to(
                        //         //   () => TermsAndConditionsView(
                        //         //     content: activeLocale == SupportedLocales().english
                        //         //         ? controller.termsAndConditions?.contentEn ??
                        //         //               'No Content'
                        //         //         : controller.termsAndConditions?.contentAr ??
                        //         //               'No Content',
                        //         //   ),
                        //         // );
                        //       },
                        //     ),
                        //     _buildActionItem(
                        //       icon: Icons.privacy_tip_outlined,
                        //       title: privacyPolicyTitle.tr,
                        //       onTap: () {
                        //         // Get.to(
                        //         // () => PrivacyPolicyView(
                        //         //   content: activeLocale == SupportedLocales().english
                        //         //       ? controller.privacyPolicy?.contentEn ?? 'No Content'
                        //         //       : controller.privacyPolicy?.contentAr ?? 'No Content',
                        //         // ),
                        //         // );
                        //       },
                        //     ),
                        //   ],
                        // ),

                        // const SizedBox(height: 24),

                        // Help And Support Section
                        // _buildSection(
                        //   title: helpAndSupportTitle.tr,
                        //   items: [
                        //     _buildActionItem(
                        //       icon: Icons.contact_support_outlined,
                        //       title: contactUsTitle.tr,
                        //       onTap: () {
                        //         // Get.to(
                        //         //   () => ContactUsView(
                        //         //     content: activeLocale == SupportedLocales().english
                        //         //         ? controller.contactUs?.contentEn ?? 'No Content'
                        //         //         : controller.contactUs?.contentAr ?? 'No Content',
                        //         //   ),
                        //         // );
                        //       },
                        //     ),
                        //     _buildActionItem(
                        //       icon: Icons.help_outline_rounded,
                        //       title: faqsTitle.tr,
                        //       onTap: () {
                        //         // Get.to(() => FaqsView());
                        //       },
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 24),

                        // Settings Section
                        _buildSection(
                          title: settingsTitle.tr,
                          items: [
                            // _buildActionItem(
                            //   icon: Icons.settings_outlined,
                            //   title: settingsTitle.tr,
                            //   onTap: () {
                            //     // Navigate to settings
                            //   },
                            // ),

                            /// language
                            _buildActionItem(
                              icon: Icons.language_rounded,
                              title: languageTitle.tr,
                              onTap: () {
                                showLanguageSelectionDialog(
                                  onLanguageChanged: (locale) async {
                                    /// update user language of push notifications
                                    // await Get.find<HomeController>().updateUserPreferences(
                                    //   body: {'language': locale.toString()},
                                    // );
                                    await LocalizationService().setLocale(locale);
                                  },
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Logout Section (separate from other sections)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(opacityToAlpha(0.05)),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildActionItem(
                                icon: Icons.logout_rounded,
                                title: logoutTitle.tr,
                                isDelete: true,
                                onTap: () {
                                  _showLogoutDialog(context);
                                },
                              ),
                            ],
                          ),
                        ),

                        const VPadding(16),
                        Center(
                          child: Text(
                            AppVersion.getVersion(),
                            style: TextStyle(color: kMutedTextColor, fontSize: 13),
                          ),
                        ),
                        const VPadding(32),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: kBlackColor,
              height: 0.7,
            ),
          ),
        ),

        // Section Items
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(opacityToAlpha(0.05)),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    bool isToggleTrailing = false,
    bool toggleValue = false,
    ValueChanged<bool>? onToggleChanged,
    bool isDelete = false,
    bool isActive = true,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F1F1), width: 1)),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive && isDelete
                ? const Color(0xFFE1574D).withAlpha(opacityToAlpha(0.1))
                : isActive && !isDelete
                ? const Color(0xFFE6E9EC)
                : const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            icon,
            size: 24,
            color: isActive && isDelete
                ? const Color(0xFFE1574D)
                : isActive && !isDelete
                ? const Color(0xFF002544)
                : const Color(0xFFC5C5C5),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isActive ? Color(0xFF2A2F3A) : Color(0xFFC5C5C5),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: isActive ? Color(0xFF2A2F3A) : Color(0xFFC5C5C5),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
        trailing: isToggleTrailing
            ? CupertinoSwitch(
                value: toggleValue,
                onChanged: isActive ? onToggleChanged : null,
                activeTrackColor: isActive
                    ? const Color(0xFF002544)
                    : Color(0xFF002544).withAlpha(opacityToAlpha(0.5)),
              )
            : Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isActive ? Color(0xFF70747B) : const Color(0xFFC5C5C5),
              ),
        onTap: isToggleTrailing ? null : onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          logout.tr,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2A2F3A),
          ),
        ),
        content: Text(
          sureToLogout.tr,
          style: const TextStyle(fontSize: 14, color: Color(0xFF70747B)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              cancel.tr,
              style: const TextStyle(color: Color(0xFF70747B), fontWeight: FontWeight.w500),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // Add logout logic here
              logoutProcedure();
            },
            child: Text(
              logout.tr,
              style: const TextStyle(color: Color(0xFFE1574D), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> logoutProcedure() async {
  // Preferences().clear();
  // accessToken = null;
  // savedEnvironment = null;
  // Get.isRegistered<CardsController>() ? Get.delete<CardsController>(force: true) : null;
  // Get.isRegistered<WebSocketService>() ? Get.delete<WebSocketService>(force: true) : null;
  Preferences().clear();
  kDriverId = null;
  Get.offAll(() => LoginView());

  // Show environment selection dialog after navigating to login

  // todo rnvironment selection dialog
  // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   showEnvironmentSelectionDialog(
  //     isDismissible: false,
  //     onEnvironmentChanged: (environment) {
  //       // Environment has been selected
  //     },
  //   );
  // });
}

class LanguageSelectionDialog extends StatefulWidget {
  const LanguageSelectionDialog({super.key, this.onLanguageChanged});

  final Function(Locale)? onLanguageChanged;

  @override
  State<LanguageSelectionDialog> createState() => _LanguageSelectionDialogState();
}

class _LanguageSelectionDialogState extends State<LanguageSelectionDialog> {
  String selectedLanguage = 'en';
  Function(Locale)? onLanguageChanged;

  @override
  void initState() {
    super.initState();
    // Set initial selection based on current locale
    selectedLanguage = activeLocale == SupportedLocales().arabic ? 'ar' : 'en';
    onLanguageChanged = widget.onLanguageChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      // height: 314,
      width: double.infinity,
      child: Column(
        children: [
          // Header
          Text(
            'Select Language',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: kBlackColor),
          ),

          // Content Section (228px height)
          _buildContent(),

          // iPhone Indicator (30px height)
          // _buildIphoneIndicator(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      // height: 228,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      color: Colors.white,
      child: Column(
        children: [
          // Language Options Container
          SizedBox(
            width: double.infinity,
            height: 140,
            child: Column(
              children: [
                // Arabic Option
                _buildLanguageOption(
                  languageCode: 'ar',
                  flagAsset: 'assets/icons/ksa_flag.png',
                  languageName: arabicLanguageName.tr,
                  isSelected: selectedLanguage == 'ar',
                ),

                const SizedBox(height: 12),

                // English Option
                _buildLanguageOption(
                  languageCode: 'en',
                  flagAsset: 'assets/icons/bastards_flag.png',
                  languageName: 'English',
                  isSelected: selectedLanguage == 'en',
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

  Widget _buildLanguageOption({
    required String languageCode,
    required String flagAsset,
    required String languageName,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = languageCode;
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
            // Flag
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(17)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Image.asset(flagAsset, width: 34, height: 34, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(width: 16),

            // Language Name
            Text(
              languageName,
              style: TextStyle(
                fontFamily: languageCode == 'ar' ? 'Montserrat-Arabic' : 'Roboto Condensed',
                fontSize: 14,
                fontWeight: languageCode == 'en' && isSelected ? FontWeight.w500 : FontWeight.w400,
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
    // Update the app locale based on selection
    if (selectedLanguage == 'ar') {
      await LocalizationService().setLocale(SupportedLocales().arabic);
    } else {
      await LocalizationService().setLocale(SupportedLocales().english);
    }

    if (onLanguageChanged != null) {
      onLanguageChanged!(activeLocale!);
    }

    // Close the bottom sheet
    Get.back();
  }
}

// Helper function to show the language selection bottom sheet
void showLanguageSelectionDialog({Function(Locale)? onLanguageChanged}) {
  showMyDialog(
    LanguageSelectionDialog(
      onLanguageChanged: (locale) => onLanguageChanged != null ? onLanguageChanged(locale) : null,
    ),
    height: 309,
  );
}
