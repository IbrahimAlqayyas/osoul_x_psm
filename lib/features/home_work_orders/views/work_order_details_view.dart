import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:osoul_x_psm/core/logging/logging.dart';
import 'package:osoul_x_psm/core/shared_widgets/base_scaffold.dart';
import 'package:osoul_x_psm/core/shared_widgets/button_gradient.dart';
import 'package:osoul_x_psm/core/shared_widgets/loading_indicator.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/core/shared_widgets/popups_dialogs.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';
import 'package:osoul_x_psm/features/home_work_orders/controllers/home_work_orders_controller.dart';
import 'package:osoul_x_psm/features/home_work_orders/controllers/work_order_details_controller.dart';
import 'package:osoul_x_psm/features/home_work_orders/models/work_order_item_line_model.dart';
import 'package:osoul_x_psm/features/home_work_orders/models/work_order_model.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/features/products/controllers/products_controller.dart';
import 'package:osoul_x_psm/features/products/views/products_view.dart';

class WorkOrderDetailsView extends StatelessWidget {
  final String type;
  final WorkOrderModel workOrder;
  const WorkOrderDetailsView({super.key, required this.type, required this.workOrder});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarHeight: 100,
      appBarPadding: EdgeInsets.only(top: 24, bottom: 16),
      showBackButton: true,
      titleWidget: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              ),
              Column(
                children: [
                  Text(
                    'Work Order: ${workOrder.values?.name ?? ''}',
                    style: Get.textTheme.titleSmall?.copyWith(color: kWhiteColor),
                  ),
                  Text(
                    'Internal ID: ${workOrder.values?.internalid?[0].value ?? ''}',
                    style: Get.textTheme.titleSmall?.copyWith(color: kWhiteColor),
                  ),
                  Text(
                    'Production Date: ${workOrder.values?.custrecordPsmFinishWoProductionDate ?? ''}',
                    style: Get.textTheme.titleSmall?.copyWith(color: kWhiteColor),
                  ),
                ],
              ),
              SizedBox(width: 24),
            ],
          ),
        ),
      ),
      body: GetBuilder(
        init: WorkOrderDetailsController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: MyGradientButton(
                  onPressed: () {
                    /// go to add products
                    Get.to(
                      () => ProductsView(
                        workOrder: workOrder,
                        onEnterPressed: () async {
                          /// call api post request
                          bool isEntered = await controller.enterItemLine(
                            type: type,
                            workOrderId: workOrder.values!.internalid![0].value!,
                            products: Get.find<ProductsController>().selectedProducts,
                          );

                          /// if succeeded - get back 4 times
                          /// refresh work orders
                          /// go to the transfer order just was opening - take id from work orders controller
                          if (isEntered) {
                            Get.back();
                            Get.back();
                            Get.back();
                            Get.back();
                            await Get.find<HomeWorkOrdersController>().getWorkOrders();
                            // Get.to(
                            //   () => WorkOrderDetailsView(
                            //     type: type,
                            //     workOrder: Get.find<HomeWorkOrdersController>().workOrders
                            //         .firstWhere(
                            //           (element) =>
                            //               element.id ==
                            //               Get.find<HomeWorkOrdersController>().selectedWorkOrderId,
                            //         ),
                            //   ),
                            // );
                            showSuccessDialog();
                          } else {
                            showFailureDialog();
                          }
                        },
                      ),
                    );
                  },
                  label: 'Add Items',
                ),
              ),

              const VPadding(16),

              if (controller.isLoading)
                const Center(child: MyProgressIndicator())
              else if (controller.workOrderItemLine.isEmpty)
                const Center(child: Text('No Data Found'))
              else
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return constraints.maxWidth > 600
                          ? MasonryGridView.count(
                              padding: const EdgeInsets.only(bottom: 100),
                              crossAxisCount: (constraints.maxWidth / 400).ceil(),
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              itemCount: controller.workOrderItemLine.length,
                              itemBuilder: (context, index) {
                                final workOrderItemLine = controller.workOrderItemLine[index];
                                return ItemLineWidget(
                                  item: workOrderItemLine,
                                  controller: controller,
                                  type: type,
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: controller.workOrderItemLine.length,
                              itemBuilder: (context, index) {
                                final workOrderItemLine = controller.workOrderItemLine[index];
                                return ItemLineWidget(
                                  item: workOrderItemLine,
                                  controller: controller,
                                  type: type,
                                );
                              },
                            );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class ItemLineWidget extends StatelessWidget {
  const ItemLineWidget({
    super.key,
    required this.item,
    required this.controller,
    required this.type,
  });

  final WorkOrderItemLineModel item;
  final WorkOrderDetailsController controller;
  final String type;

  String _getAssetByType(String type) {
    kLog('type: $type');
    if (type == 'Chickens') {
      return 'assets/icons/chicken.png';
    } else if (type == 'Portions') {
      return 'assets/icons/portions2.png';
    } else if (type == 'Coby') {
      return 'assets/icons/coby.png';
    } else if (type == 'Marinated') {
      return 'assets/icons/marinated.png';
    } else {
      return 'assets/logo.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      // margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kMutedTextColor.withAlpha(opacityToAlpha(0.3)), width: 1),
        boxShadow: [
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
                child: Center(child: Image.asset(_getAssetByType(type), height: 26)),
              ),
              const HPadding(12),

              /// Item Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.item.toString(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor,
                        height: 1.3,
                      ),
                    ),
                    const VPadding(4),
                    Text(
                      item.itemName.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: kBlackColor.withAlpha(opacityToAlpha(0.6)),
                      ),
                    ),
                    const VPadding(4),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: ${item.totalquantity.toString() == '' ? '0' : item.totalquantity.toString()}',
                          style: TextStyle(
                            fontSize: 14,
                            color: kBlackColor.withAlpha(opacityToAlpha(0.6)),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const HPadding(24),
                        Text(
                          'Produced: ${item.prducedquantity.toString() == '' ? '0' : item.prducedquantity.toString()}',
                          style: TextStyle(
                            fontSize: 14,
                            color: kBlackColor.withAlpha(opacityToAlpha(0.6)),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
