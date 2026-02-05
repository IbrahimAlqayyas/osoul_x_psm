import 'package:get/get.dart';
import 'package:osoul_x_psm/core/preferences/preferences.dart';
import 'package:osoul_x_psm/features/auth/models/user_model.dart';
import 'package:osoul_x_psm/features/home/models/work_order_model.dart';

String? kDriverId;

class HomeController extends GetxController {
  UserModel? user;
  bool isDrawerOpen = false;

  bool isLoading = false;

  List<WorkOrderModel> workOrders = [
    WorkOrderModel(id: '1KGHIIR34T', productionDate: '2022-01-01'),
    WorkOrderModel(id: '1KGHIIR34T', productionDate: '2022-01-02'),
    WorkOrderModel(id: '1KGHIIR34T', productionDate: '2022-01-03'),
    WorkOrderModel(id: '1KGHIIR34T', productionDate: '2022-01-04'),
    WorkOrderModel(id: '1KGHIIR34T', productionDate: '2022-01-05'),
    WorkOrderModel(id: '1KGHIIR34T', productionDate: '2022-01-06'),
    WorkOrderModel(id: '1KGHIIR34T', productionDate: '2022-01-07'),
    WorkOrderModel(id: '1KGHIIR34T', productionDate: '2022-01-08'),
    WorkOrderModel(id: '1KGHIIR34T', productionDate: '2022-01-09'),
    WorkOrderModel(id: '1KGHIIR34T', productionDate: '2022-01-10'),
  ];

  Future<void> getUserModel() async {
    isLoading = true;
    update();
    user = await Preferences().getSavedUser();
    kDriverId = user?.driverid;
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getUserModel();
  }
}
