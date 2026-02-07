import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/localization/03_supported_locales.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';
import 'package:osoul_x_psm/core/theme/text_styles.dart';
import 'package:osoul_x_psm/features/home_work_orders/views/drawer.dart';
import 'package:osoul_x_psm/main.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.title,
    required this.body,
    this.showBackButton = true,
    this.isDrawerButton = false,
    this.applyPadding = true,
    this.enableScroll = false,
    this.action,
    this.bottomNavigationBar,
    this.appBarHeight,
    this.titleWidget,
    this.appBarPadding,
  });

  final String? title;
  final Widget body;
  final bool showBackButton;
  final bool isDrawerButton;
  final bool applyPadding;
  final Widget? action;
  final Widget? bottomNavigationBar;
  final bool enableScroll;
  final num? appBarHeight;
  final Widget? titleWidget;
  final EdgeInsets? appBarPadding;

  @override
  Widget build(BuildContext context) {
    assert(titleWidget != null || title != null);
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF7F7F7),
      bottomNavigationBar: bottomNavigationBar,
      drawer: isDrawerButton ? Drawer(child: DrawerView()) : null,
      body: Column(
        children: [
          /// Header with back arrow and title
          Container(
            height: appBarHeight?.toDouble() ?? 70,
            decoration: BoxDecoration(
              gradient: kMainGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: appBarPadding ?? const EdgeInsets.only(left: 20, right: 20, top: 16),
              child:
                  titleWidget ??
                  Row(
                    children: [
                      if (isDrawerButton)
                        GestureDetector(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: const SizedBox(
                            width: 22,
                            height: 22,
                            child: Icon(Icons.menu_rounded, color: Colors.white),
                          ),
                        ),
                      if (showBackButton)
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                        )
                      else
                        const SizedBox(width: 24, height: 24),
                      Expanded(
                        child: Text(
                          title ?? '',
                          textAlign: TextAlign.center,
                          style: kHeaderTitle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (action != null) action!,

                      if (action == null)
                        const SizedBox(width: 40), // Balance the back button space
                    ],
                  ),
            ),
          ),

          /// Main content area
          Expanded(
            child: Container(
              width: double.infinity,
              padding: applyPadding ? const EdgeInsets.only(top: 16, left: 16, right: 16) : null,
              decoration: const BoxDecoration(color: kWhiteColor),
              child: enableScroll ? SingleChildScrollView(child: body) : body,
            ),
          ),
        ],
      ),
    );
  }
}
