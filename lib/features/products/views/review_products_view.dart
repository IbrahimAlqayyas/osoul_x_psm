import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:osoul_x_psm/core/constants/ui_constants.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/shared_widgets/base_scaffold.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_gradient.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_rounded.dart';
import 'package:osoul_x_psm/core/shared_widgets/custom_textfield_widget.dart';
import 'package:osoul_x_psm/core/shared_widgets/loading_indicator.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/core/shared_widgets/popups_dialogs.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';
import 'package:osoul_x_psm/features/products/controllers/products_controller.dart';
import 'package:osoul_x_psm/features/products/models/product_model.dart';
// import 'package:osoul_x_psm/features/transfer_orders/controllers/add_transfer_order_controller.dart';
// import 'package:osoul_x_psm/features/transfer_orders/views/add_edit_transfer_order_view.dart';
import 'package:osoul_x_psm/main.dart';
import 'package:get/get.dart';

class ProductsSelectionReviewView extends StatelessWidget {
  const ProductsSelectionReviewView({super.key, required this.onEnterPressed});
  final VoidCallback onEnterPressed;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Items Quantities',
      body: GetBuilder(
        init: ProductsController(),
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: kMainGradient.scale(0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedProducts.tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${controller.selectedProducts.length}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: kRoboto,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const VPadding(16),

              // Selected Items List
              SizedBox(
                height: getBodyHeight() - 162,
                child: GetBuilder<ProductsController>(
                  builder: (controller) => GridView.builder(
                    padding: const EdgeInsets.only(bottom: 350),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      mainAxisExtent: 220,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: controller.selectedProducts.length,
                    itemBuilder: (context, index) {
                      return ProductInReviewWidget(
                        item: controller.selectedProducts[index],
                        controller: controller,
                        isSelected: true,
                        isEdit: false,
                      );
                    },
                  ),
                ),
              ),

              // Create Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: controller.isLoadingEnter
                    ? MyProgressIndicator()
                    : MyGradientButton(label: 'Enter', onPressed: onEnterPressed),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProductInReviewWidget extends StatelessWidget {
  const ProductInReviewWidget({
    super.key,
    required this.item,
    required this.controller,
    required this.isSelected,
    required this.isEdit,
  });

  final ProductModel item;
  final ProductsController controller;
  final bool isSelected;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      // margin: const EdgeInsets.only(bottom: 12),
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
        mainAxisSize: MainAxisSize.min,
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
                child: Center(child: Image.asset('assets/icons/chicken_face.png', height: 26)),
              ),
              const HPadding(12),

              // Item Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.itemName ?? 'N/A',
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
                      '${code.tr}: ${item.item ?? 'N/A'}',
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
                      controller.selectedProducts.remove(item);
                      controller.nonSelectedProducts.add(item);
                    } else {
                      controller.selectedProducts.add(item);
                      controller.nonSelectedProducts.remove(item);
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
                        hint: '${item.totalquantity ?? 0}',
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
