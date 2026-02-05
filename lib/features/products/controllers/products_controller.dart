import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/network/services.dart';
import 'package:osoul_x_psm/features/products/models/product_model.dart';

class ProductsController extends GetxController {
  TextEditingController searchController = TextEditingController();
  

  List<ItemToAddInTransferOrderModel> itemsToShow = [];

  List<ItemToAddInTransferOrderModel> selectedItems = [];
  List<ItemToAddInTransferOrderModel> nonSelectedItems = [];
  bool isLoadingItems = false;
  
  Future<void> getItemsToAddInTransferOrder() async {
    isLoadingItems = true;
    update();
    itemsToShow = (await Services().getItemsToAddInTransferOrder(false)) ?? [];
    nonSelectedItems = itemsToShow;
    nonSelectedItems.removeWhere(
      (item) => selectedItems.any((selectedItem) => selectedItem.id == item.id),
    );
    isLoadingItems = false;
    update();
  }

  void toggleItemSelection(ItemToAddInTransferOrderModel item) {
    item.isSelected = !item.isSelected;
    if (item.isSelected && (item.quantity == null || item.quantity == 0)) {
      item.quantity = 1; // Default quantity when selected
    }
    update();
  }

  void incrementQuantity(ItemToAddInTransferOrderModel item) {
    item.quantity = (item.quantity ?? 0) + 1;
    item.textController!.text = item.quantity.toString();
    update();
  }

  void decrementQuantity(ItemToAddInTransferOrderModel item) {
    if ((item.quantity ?? 0) > 1) {
      item.quantity = (item.quantity ?? 0) - 1;
      item.textController!.text = item.quantity.toString();
    }
    update();
  }

  void updateQuantity(ItemToAddInTransferOrderModel item, num value) {
    item.quantity = value;
    update();
  }

  @override
  void onInit() {
    getItemsToAddInTransferOrder();
    super.onInit();
  }
}
