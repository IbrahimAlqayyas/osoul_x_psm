import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:osoul_x_psm/core/constants/ui_constants.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/shared_widgets/base_scaffold.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/shared_widgets/custom_textfield_widget.dart';
import 'package:osoul_x_psm/core/shared_widgets/loading_indicator.dart';
import 'package:osoul_x_psm/core/shared_widgets/no_items_widget.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';
import 'package:osoul_x_psm/features/home/models/work_order_model.dart';
import 'package:osoul_x_psm/features/products/controllers/products_controller.dart';
import 'package:osoul_x_psm/features/products/models/product_model.dart';
import 'package:osoul_x_psm/features/products/views/review_products_view.dart';
// import 'package:osoul_x_psm/features/transfer_orders/controllers/add_transfer_order_controller.dart';
// import 'package:osoul_x_psm/features/transfer_orders/controllers/transfer_orders_controller.dart';
// import 'package:osoul_x_psm/features/transfer_orders/models/items_to_add_in_transfer_order.dart';
// import 'package:osoul_x_psm/features/transfer_orders/models/transfer_order_model.dart';
// import 'package:osoul_x_psm/features/transfer_orders/views/summary_and_confirm_transfer_order_view.dart';
import 'package:osoul_x_psm/main.dart';

class AddEditTransferOrderView extends StatelessWidget {
  const AddEditTransferOrderView({
    super.key,
    this.isEdit = false,
    this.filterText = '',
    required this.workOrder,
  });

  final bool isEdit;
  final String filterText;
  final WorkOrderModel workOrder;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: createTransferOrderTitle.tr,
      body: GetBuilder<ProductsController>(
        init: ProductsController(),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getItemsToAddInTransferOrder(),
            child: controller.isLoadingItems
                ? const Padding(padding: EdgeInsets.only(top: 150), child: MyProgressIndicator())
                : controller.itemsToShow.isEmpty
                ? const Padding(padding: EdgeInsets.only(top: 150), child: NoItemsWidget())
                : Column(
                    children: [
                      /// counting
                      GestureDetector(
                        onTap: () {
                          if (isEdit == false) {
                            if (controller.selectedItems.isNotEmpty) {
                              Get.to(() => SummaryAndConfirmTransferOrderView());
                            }
                          } else {
                            Get.back();
                            Get.back();
                          }
                        },
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: kMainGradient.scale(0.3),
                            border: Border(
                              bottom: BorderSide(
                                color: kPrimaryColor.withAlpha(opacityToAlpha(0.3)),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedProducts.tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${controller.selectedItems.length}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: kRoboto,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                              if (controller.selectedItems.isNotEmpty) ...[
                                const HPadding(12),
                                const Icon(Icons.arrow_forward_ios, color: kPrimaryColor, size: 20),
                              ],
                            ],
                          ),
                        ),
                      ),

                      const VPadding(16),

                      /// search
                      CustomTextFieldWidget(
                        hint: searchKeyword.tr,
                        controller: controller.searchController,
                        suffixIcon: const Icon(Icons.search, color: kSecondaryColor),
                        onChanged: (str) {
                          if (str.isNotEmpty) {
                            controller.nonSelectedItems = controller.itemsToShow
                                .where(
                                  (element) =>
                                      element.name!.toLowerCase().contains(str.toLowerCase()) ||
                                      element.code!.toLowerCase().contains(str.toLowerCase()),
                                )
                                .toList();
                            controller.update();
                          } else {
                            controller.nonSelectedItems = controller.itemsToShow
                                .where((e) => !controller.selectedItems.contains(e))
                                .toList();
                            controller.update();
                          }
                        },
                      ),

                      // Available Items Section
                      Column(
                        children: [
                          controller.nonSelectedItems.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(32),
                                    child: Text(
                                      allProductsSelected.tr,
                                      style: TextStyle(fontSize: 16, color: kMutedTextColor),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: getBodyHeight() - 136,
                                  child: ListView.builder(
                                    // padding: const EdgeInsets.all(16),
                                    itemCount: controller.nonSelectedItems.length,
                                    itemBuilder: (context, index) {
                                      return ItemToAddInTransferOrderWidget(
                                        item: controller.nonSelectedItems[index],
                                        controller: controller,
                                        isSelected: false,
                                        isEdit: isEdit,
                                      );
                                    },
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
  }
}

class ItemToAddInTransferOrderWidget extends StatelessWidget {
  const ItemToAddInTransferOrderWidget({
    super.key,
    required this.item,
    required this.controller,
    required this.isSelected,
    required this.isEdit,
  });

  final ItemToAddInTransferOrderModel item;
  final ProductsController controller;
  final bool isSelected;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? kPrimaryColor.withAlpha(opacityToAlpha(0.6))
              : kMutedTextColor.withAlpha(opacityToAlpha(0.3)),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: kPrimaryColor.withAlpha(opacityToAlpha(0.15)),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(opacityToAlpha(0.05)),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon (Frozen/Fresh)
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withAlpha(opacityToAlpha(0.1)),

                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kPrimaryColor.withAlpha(opacityToAlpha(0.3)), width: 1),
                ),
                child: Center(child: Image.asset('assets/icons/fresh.png', height: 26)),
              ),
              const HPadding(12),

              // Item Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name ?? 'N/A',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: kBlackColor,
                        height: 1.3,
                      ),
                    ),
                    const VPadding(4),
                    Text(
                      '${code.tr}: ${item.code ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 12,
                        color: kBlackColor.withAlpha(opacityToAlpha(0.6)),
                      ),
                    ),
                  ],
                ),
              ),

              const HPadding(8),
              MySmallButton(
                isSelected: isSelected,
                onTap: () {
                  if (isEdit) {
                    // Get.find<TransferOrdersController>().transferOrderDetails!.items!.add(
                    //   TransferOrderItemModel(
                    //     itemid: item.id,
                    //     quantity: item.quantity,
                    //     updatedQuantity: 1,
                    //     item: item.name,
                    //     name: item.name,
                    //     quantityController: TextEditingController(text: '1'),
                    //   ),
                    // );
                    // Get.find<TransferOrdersController>().update();
                    // controller.selectedItems.add(item);
                    // controller.nonSelectedItems.remove(item);
                  } else {
                    if (isSelected) {
                      controller.selectedItems.remove(item);
                      controller.nonSelectedItems.add(item);
                    } else {
                      controller.selectedItems.add(item);
                      controller.nonSelectedItems.remove(item);
                    }
                  }

                  controller.update();
                },
              ),
            ],
          ),

          // Quantity Controls (only for selected items)
          if (isSelected) ...[
            const VPadding(12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kPrimaryColor.withAlpha(opacityToAlpha(0.05)),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kPrimaryColor.withAlpha(opacityToAlpha(0.2)), width: 1),
              ),
              child: Row(
                children: [
                  Text(
                    '${quantity.tr}:',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  const HPadding(8),

                  // Decrement Button
                  GestureDetector(
                    onTap: () => controller.decrementQuantity(item),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: kPrimaryColor.withAlpha(opacityToAlpha(0.4)),
                          width: 1,
                        ),
                      ),
                      child: const Icon(Icons.remove, size: 16, color: kPrimaryColor),
                    ),
                  ),

                  const HPadding(8),

                  // Quantity TextField
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: CustomTextFieldWidget(
                        controller: item.textController!,
                        hint: '${item.quantity ?? 0}',
                        keyBoardType: TextInputType.number,
                        formatters: [FilteringTextInputFormatter.digitsOnly],
                        isCentered: true,
                        onChanged: (value) {
                          final qty = num.tryParse(value) ?? 0;
                          controller.updateQuantity(item, qty);
                        },
                      ),
                    ),
                  ),

                  const HPadding(8),

                  // Increment Button
                  GestureDetector(
                    onTap: () => controller.incrementQuantity(item),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: kMainGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add, size: 16, color: kWhiteColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
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
