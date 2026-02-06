import 'package:get/get.dart';
import 'package:osoul_x_psm/core/network/services.dart';
import 'package:osoul_x_psm/features/home_work_orders/controllers/home_work_orders_controller.dart';
import 'package:osoul_x_psm/features/home_work_orders/models/work_order_item_line_model.dart';

class WorkOrderDetailsController extends GetxController {
  bool isLoading = false;
  List<WorkOrderItemLineModel> workOrderItemLine = [];

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
