import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/network/services.dart';
import 'package:osoul_x_psm/features/products/models/product_model.dart';

class ProductsController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<ProductModel> productsToShow = [];

  List<ProductModel> selectedProducts = [];
  List<ProductModel> nonSelectedProducts = [];
  bool isLoadingProducts = false;

  Future<void> getProducts() async {
    isLoadingProducts = true;
    update();
    productsToShow = (await Services().getProducts(false)) ?? [];
    nonSelectedProducts = productsToShow;
    nonSelectedProducts.removeWhere(
      (item) => selectedProducts.any((selectedItem) => selectedItem.id == item.id),
    );
    isLoadingProducts = false;
    update();
  }

  void toggleItemSelection(ProductModel item) {
    item.isSelected = !item.isSelected;
    if (item.isSelected && (item.quantity == null || item.quantity == 0)) {
      item.quantity = 1; // Default quantity when selected
    }
    update();
  }

  void incrementQuantity(ProductModel item) {
    item.quantity = (item.quantity ?? 0) + 1;
    item.textController!.text = item.quantity.toString();
    update();
  }

  void decrementQuantity(ProductModel item) {
    if ((item.quantity ?? 0) > 1) {
      item.quantity = (item.quantity ?? 0) - 1;
      item.textController!.text = item.quantity.toString();
    }
    update();
  }

  void updateQuantity(ProductModel item, num value) {
    item.quantity = value;
    update();
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }
}
