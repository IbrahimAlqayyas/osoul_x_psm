import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';
import 'package:osoul_x_psm/core/shared_widgets/base_scaffold.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_rounded.dart';
import 'package:osoul_x_psm/core/shared_widgets/custom_textfield_widget.dart';
import 'package:osoul_x_psm/core/shared_widgets/loading_indicator.dart';
import 'package:osoul_x_psm/core/shared_widgets/no_items_widget.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';
import 'package:osoul_x_psm/features/home_work_orders/models/work_order_model.dart';
import 'package:osoul_x_psm/features/products/controllers/products_controller.dart';
import 'package:osoul_x_psm/features/products/models/product_model.dart';
import 'package:osoul_x_psm/features/products/views/review_products_view.dart';
import 'package:osoul_x_psm/main.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({
    super.key,
    this.filterText = '',
    required this.workOrder,
    required this.onEnterPressed,
  });

  final String filterText;
  final WorkOrderModel workOrder;
  final VoidCallback onEnterPressed;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Items List',
      body: GetBuilder<ProductsController>(
        init: ProductsController(),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getProducts(),
            child: controller.isLoadingProducts
                ? const Padding(padding: EdgeInsets.only(top: 100), child: MyProgressIndicator())
                : controller.productsToShow.isEmpty
                ? const Padding(padding: EdgeInsets.only(top: 100), child: NoItemsWidget())
                : Column(
                    children: [
                      /// counting
                      GestureDetector(
                        onTap: () {
                          if (controller.selectedProducts.isNotEmpty) {
                            Get.to(
                              () => ProductsSelectionReviewView(onEnterPressed: onEnterPressed),
                            );
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
                                  '${controller.selectedProducts.length}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: kRoboto,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                              if (controller.selectedProducts.isNotEmpty) ...[
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
                            controller.nonSelectedProducts = controller.productsToShow
                                .where(
                                  (element) =>
                                      element.itemName!.toLowerCase().contains(str.toLowerCase()) ||
                                      element.item!.toLowerCase().contains(str.toLowerCase()),
                                )
                                .toList();
                            controller.update();
                          } else {
                            controller.nonSelectedProducts = controller.productsToShow
                                .where((e) => !controller.selectedProducts.contains(e))
                                .toList();
                            controller.update();
                          }
                        },
                      ),

                      // Available Items Section
                      Expanded(
                        child: controller.nonSelectedProducts.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.all(32),
                                  child: Text(
                                    allProductsSelected.tr,
                                    style: TextStyle(fontSize: 16, color: kMutedTextColor),
                                  ),
                                ),
                              )
                            : LayoutBuilder(
                                builder: (context, constraints) {
                                  return constraints.maxWidth > 600
                                      ? GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 500,
                                                mainAxisExtent: 180,
                                                crossAxisSpacing: 16,
                                                mainAxisSpacing: 16,
                                              ),
                                          itemCount: controller.nonSelectedProducts.length,
                                          itemBuilder: (context, index) {
                                            return ProductToReviewWidget(
                                              item: controller.nonSelectedProducts[index],
                                              controller: controller,
                                              isSelected: false,
                                            );
                                          },
                                        )
                                      : ListView.builder(
                                          itemCount: controller.nonSelectedProducts.length,
                                          itemBuilder: (context, index) {
                                            return ProductToReviewWidget(
                                              item: controller.nonSelectedProducts[index],
                                              controller: controller,
                                              isSelected: false,
                                            );
                                          },
                                        );
                                },
                              ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class ProductToReviewWidget extends StatelessWidget {
  const ProductToReviewWidget({
    super.key,
    required this.item,
    required this.controller,
    required this.isSelected,
  });

  final ProductModel item;
  final ProductsController controller;
  final bool isSelected;

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
                  if (isSelected) {
                    controller.selectedProducts.remove(item);
                    controller.nonSelectedProducts.add(item);
                  } else {
                    controller.selectedProducts.add(item);
                    controller.nonSelectedProducts.remove(item);
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
