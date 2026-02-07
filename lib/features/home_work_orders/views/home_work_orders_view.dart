import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/constants/ui_constants.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/localization/04_localization_service.dart';
import 'package:osoul_x_psm/core/shared_widgets/base_scaffold.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_rounded.dart';
import 'package:osoul_x_psm/core/shared_widgets/image_default.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/core/shared_widgets/popups_dialogs.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';
// import 'package:osoul_x_psm/features/collect/views/collect_view.dart';
import 'package:osoul_x_psm/features/home_work_orders/controllers/home_work_orders_controller.dart';
import 'package:osoul_x_psm/features/home_work_orders/models/work_order_model.dart';
import 'package:osoul_x_psm/features/home_work_orders/views/drawer.dart';
import 'package:osoul_x_psm/features/home_work_orders/views/work_order_details_view.dart';
import 'package:osoul_x_psm/features/products/views/products_view.dart';
import 'package:osoul_x_psm/main.dart';
// import 'package:osoul_x_psm/features/returns/views/return_view.dart';
// import 'package:osoul_x_psm/features/transfer_orders/views/transfer_orders_view.dart';
// import 'package:osoul_x_psm/features/sales/views/sales_view.dart';
// import 'package:osoul_x_psm/features/stock/views/stock_view.dart';

class HomeViewWorkOrders extends StatelessWidget {
  const HomeViewWorkOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isDrawerButton: true,
      // appBarHeight: 130,
      appBarPadding: const EdgeInsets.only(top: 24, bottom: 16),
      // titleWidget: const UserGreetingHeader(),
      titleWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 24),

            Text(
              workOrdersTitle.tr,
              style: Get.textTheme.titleMedium?.copyWith(color: kWhiteColor),
            ),
            buildActionButton(
              onTap: () {
                // Get.to(() => const NotificationView());
                // Scaffold.of(context).openDrawer();
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
              iconData: Icons.language,
              fillColor: kWhiteColor,
            ),
          ],
        ),
      ),
      showBackButton: false,
      body: GetBuilder(
        init: HomeWorkOrdersController(),
        builder: (controller) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: constraints.maxWidth > 600
                    ? GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 500,
                          mainAxisExtent: 150,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: controller.workOrders.length,
                        itemBuilder: (context, index) =>
                            _buildWorkOrderItem(context, controller, index),
                      )
                    : ListView.builder(
                        itemCount: controller.workOrders.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildWorkOrderItem(context, controller, index),
                        ),
                      ),
              );
            },
          );
        },
      ),
    );
  }

  // Widget _buildFeatureButton({
  //   required String title,
  //   String? subtitle,
  //   required IconData icon,
  //   required VoidCallback onTap,
  //   LinearGradient? gradient,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         gradient: gradient ?? kMainGradient,
  //         borderRadius: BorderRadius.circular(16),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withAlpha(opacityToAlpha(0.1)),
  //             blurRadius: 10,
  //             offset: const Offset(0, 4),
  //           ),
  //         ],
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(icon, size: 35, color: Colors.white),
  //           const SizedBox(height: 12),
  //           Text(
  //             title,
  //             style: const TextStyle(
  //               fontSize: 18,
  //               // fontWeight: FontWeight.bold,
  //               color: kWhiteColor,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),

  //           if (subtitle != null) const SizedBox(height: 4),
  //           if (subtitle != null)
  //             Text(
  //               subtitle,
  //               style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(opacityToAlpha(0.8))),
  //               textAlign: TextAlign.center,
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildWorkOrderItem(BuildContext context, HomeWorkOrdersController controller, int index) {
    return GestureDetector(
      onTap: () {
        showMyDialog(
          GetBuilder(
            init: HomeWorkOrdersController(),
            builder: (controller) {
              return SizedBox(
                width: Get.width,
                child: Column(
                  children: [
                    Text(
                      chooseCategory.tr,
                      style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const VPadding(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: MyCategoryButton(
                            onTap: () {
                              controller.selectedType = 'Chickens';
                              controller.selectedWorkOrderId =
                                  controller.workOrders[index].values!.internalid![0].value!;
                              Get.to(
                                () => WorkOrderDetailsView(
                                  type: 'Chickens',
                                  workOrder: controller.workOrders[index],
                                ),
                              );
                            },
                            assetPath: 'assets/icons/chicken.png',
                            title: chickensCategory.tr,
                          ),
                        ),
                        const HPadding(16),
                        Expanded(
                          child: MyCategoryButton(
                            onTap: () {
                              controller.selectedType = 'Portions';
                              controller.selectedWorkOrderId =
                                  controller.workOrders[index].values!.internalid![0].value!;
                              Get.to(
                                () => WorkOrderDetailsView(
                                  type: 'Portions',
                                  workOrder: controller.workOrders[index],
                                ),
                              );
                            },
                            assetPath: 'assets/icons/portions2.png',
                            title: portionsCategory.tr,
                          ),
                        ),
                      ],
                    ),
                    const VPadding(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: MyCategoryButton(
                            onTap: () {
                              controller.selectedType = 'Coby';
                              controller.selectedWorkOrderId =
                                  controller.workOrders[index].values!.internalid![0].value!;
                              Get.to(
                                () => WorkOrderDetailsView(
                                  type: 'Coby',
                                  workOrder: controller.workOrders[index],
                                ),
                              );
                            },
                            assetPath: 'assets/icons/coby.png',
                            title: cobyCategory.tr,
                          ),
                        ),
                        const HPadding(16),
                        Expanded(
                          child: MyCategoryButton(
                            onTap: () {
                              controller.selectedType = 'Marinated';
                              controller.selectedWorkOrderId =
                                  controller.workOrders[index].values!.internalid![0].value!;
                              Get.to(
                                () => WorkOrderDetailsView(
                                  type: 'Marinated',
                                  workOrder: controller.workOrders[index],
                                ),
                              );
                            },
                            assetPath: 'assets/icons/marinated.png',
                            title: marinatedCategory.tr,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      child: WorkOrderItem(workOrderItem: controller.workOrders[index]),
    );
  }
}

class WorkOrderItem extends StatelessWidget {
  const WorkOrderItem({
    super.key,
    required this.workOrderItem,
    // required this.onDeliveryPressed,
    // required this.onEditPressed,
    // required this.onShowPressed,
    // required this.onReceiptPressed,
    // this.enableEdit = false,
  });

  final WorkOrderModel workOrderItem;
  // final Function() onDeliveryPressed;
  // final Function() onEditPressed;
  // final Function() onShowPressed;
  // final Function() onReceiptPressed;
  // final bool? enableEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kPrimaryColor.withAlpha(opacityToAlpha(0.2)), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(opacityToAlpha(0.05)),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Leading Icon
            Container(
              width: 48,
              height: 108,
              decoration: BoxDecoration(
                color: kPrimaryColor.withAlpha(opacityToAlpha(0.1)),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kPrimaryColor.withAlpha(opacityToAlpha(0.3)), width: 1),
              ),
              child: Icon(Icons.local_shipping_outlined, color: kPrimaryColor, size: 28),
            ),
            const HPadding(8),

            // Transfer Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    workOrderLabel.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  const VPadding(4),
                  Row(
                    children: [
                      Text(
                        idLabel.tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        workOrderItem.id ?? '- -',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  const VPadding(4),
                  // Transaction ID
                  Row(
                    children: [
                      Text(
                        nameLabel.tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        workOrderItem.values?.name ?? '- -',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  const VPadding(4),
                  Row(
                    children: [
                      Text(
                        productionDateLabel.tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        workOrderItem.values?.custrecordPsmFinishWoProductionDate ?? '- -',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper methods for status styling
Color getStatusColor(String? status) {
  switch (status) {
    case 'pendingFulfillment':
      return kOrangeColor; // Orange
    case 'fullyBilled':
      return kGreenColor; // Green
    case 'pendingBillingPartFulfilled':
      return kOrangeColor; // Red
    case 'pendingBilling':
      return kOrangeColor; // Red
    default:
      return kSecondaryColor;
  }
}

String getStatusText(String? status) {
  switch (status) {
    case 'pendingFulfillment':
      return statusWaitingFulfillment.tr;
    case 'fullyBilled':
      return statusFullyBilled.tr;
    case 'pendingBillingPartFulfilled':
      return statusPartiallyFulfilled.tr;
    case 'pendingBilling':
      return statusPendingBilling.tr;
    default:
      return status ?? unknown.tr;
  }
}

IconData getStatusIcon(String? status) {
  switch (status) {
    case 'pendingFulfillment':
      return Icons.pending;
    case 'fullyBilled':
      return Icons.check_circle;
    case 'pendingBillingPartFulfilled':
      return Icons.pending;
    case 'pendingBilling':
      return Icons.pending;
    default:
      return Icons.info;
  }
}

// class UserGreetingHeader extends StatelessWidget {
//   const UserGreetingHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: GetBuilder(
//         init: HomeController(),
//         builder: (controller) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               /// User info container
//               _userInfo(controller: controller),

//               /// Buttons
//               buildActionButton(
//                 onTap: () {
//                   // Get.to(() => const NotificationView());
//                   Scaffold.of(context).openDrawer();
//                 },
//                 iconData: Icons.notes,
//                 fillColor: kWhiteColor,
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _userInfo({required HomeController controller}) {
//     final user = controller.user;

//     // final selectedWallet = user?.wallets?.firstWhereOrNull((e) => e.isSelected == true);

//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.0),
//         color: Colors.white.withAlpha(opacityToAlpha(0.1)),
//         border: Border.all(color: Colors.white.withAlpha(opacityToAlpha(0.1))),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,

//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.min,

//             children: [
//               SizedBox(
//                 height: 48,
//                 width: 60,
//                 child: Stack(
//                   alignment: AlignmentDirectional.bottomStart,
//                   children: [
//                     Container(
//                       width: 48,
//                       height: 48,
//                       margin: const EdgeInsetsDirectional.only(start: 6),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                         border: Border.all(color: const Color(0xFF114362), width: 1.0),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(50),
//                         child: defaultUserImageNetwork(
//                           user?.picture ??
//                               'https://cdn-icons-png.flaticon.com/128/3135/3135715.png',
//                         ),
//                       ),
//                     ),
//                     // Align(
//                     //   alignment: AlignmentDirectional.bottomStart,
//                     //   child: Container(
//                     //     width: 28,
//                     //     height: 28,
//                     //     padding: const EdgeInsets.all(4),
//                     //     decoration: BoxDecoration(
//                     //       color: const Color(0xFFD4DDE3),
//                     //       shape: BoxShape.circle,
//                     //       border: Border.all(color: const Color(0xFF1A3A56), width: 2.0),
//                     //     ),
//                     //     child: Image.asset(
//                     //       'assets/icons/user_account_badge.png',
//                     //       fit: BoxFit.fill,
//                     //       width: 20,
//                     //       height: 20,
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 8),

//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     '${hello.tr} ${user?.drivername ?? ''}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       // fontFamily: kRoboto,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     vanDriver.tr,
//                     style: const TextStyle(
//                       color: Color(0xFFF5A623),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const HPadding(12),
//           const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFF5A623), size: 16),
//         ],
//       ),
//     );
//   }
// }

Widget buildActionButton({
  required IconData iconData,
  required VoidCallback? onTap,
  num height = 40,
  num width = 40,
  bool isObscured = false,
  Color? fillColor,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width.toDouble(),
      height: height.toDouble(),
      // padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            fillColor?.withAlpha(opacityToAlpha(0.1)) ?? kBlackColor.withAlpha(opacityToAlpha(0.1)),
        border: Border.all(color: Colors.white.withAlpha(opacityToAlpha(0.1))),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [Icon(iconData, color: Colors.white)],
      ),
    ),
  );
}
