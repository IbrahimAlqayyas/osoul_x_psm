import 'package:get/get.dart';
import 'package:osoul_x_psm/core/network/services.dart';
import 'package:osoul_x_psm/features/home_work_orders/controllers/home_work_orders_controller.dart';
import 'package:osoul_x_psm/features/home_work_orders/models/work_order_item_line_model.dart';
import 'package:osoul_x_psm/features/products/models/product_model.dart';

class WorkOrderDetailsController extends GetxController {
  bool isLoading = false;
  List<WorkOrderItemLineModel> workOrderItemLine = [];

  Future<bool> enterItemLine({
    required String type,
    required String workOrderId,
    required List<ProductModel> products,
  }) async {
    isLoading = true;
    update();

    Map<String, dynamic> body = {
      "workorderid": workOrderId,
      "type": type,
      "items": [
        for (var product in products) {"item": product.item, "quantity": product.totalquantity},
      ],
    };
    bool isEntered = await Services().enterItemLine(body);

    isLoading = false;
    update();

    return isEntered;
  }

  Future<void> getWorkOrderItemLine(String type) async {
    isLoading = true;
    update();

    workOrderItemLine = (await Services().getWorkOrderItemLine(type)) ?? [];

    isLoading = false;
    update();
  }

  @override
  void onInit() {
    String type = Get.find<HomeWorkOrdersController>().selectedType;
    getWorkOrderItemLine(type.toLowerCase());
    super.onInit();
  }
}
