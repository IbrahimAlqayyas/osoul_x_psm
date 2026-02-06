import 'package:get/get.dart';
import 'package:osoul_x_psm/core/network/services.dart';
import 'package:osoul_x_psm/core/preferences/preferences.dart';
import 'package:osoul_x_psm/features/auth/models/user_model.dart';
import 'package:osoul_x_psm/features/home_work_orders/models/work_order_model.dart';

String? kDriverId;

class HomeWorkOrdersController extends GetxController {
  UserModel? user;
  bool isDrawerOpen = false;

  bool isLoading = false;

  List<WorkOrderModel> workOrders = [];
  String? selectedWorkOrderId;
  String selectedType = '';

  Future<void> getWorkOrders() async {
    isLoading = true;
    update();
    workOrders = await Services().getWorkOrders() ?? [];
    isLoading = false;
    update();
  }

  // Future<void> getUserModel() async {
  //   isLoading = true;
  //   update();
  //   user = await Preferences().getSavedUser();
  //   kDriverId = user?.driverid;
  //   isLoading = false;
  //   update();
  // }

  Future<void> initialize() async {
    // await getUserModel();
    await getWorkOrders();
  }

  @override
  void onInit() {
    super.onInit();
    initialize();
  }
}
