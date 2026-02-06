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
  bool isLoadingEnter = false;

  Future<void> getProducts() async {
    isLoadingProducts = true;
    update();
    productsToShow = (await Services().getProducts()) ?? [];
    nonSelectedProducts = productsToShow;
    nonSelectedProducts.removeWhere(
      (item) => selectedProducts.any((selectedItem) => selectedItem.item == item.item),
    );
    isLoadingProducts = false;
    update();
  }

  void toggleItemSelection(ProductModel item) {
    item.isSelected = !item.isSelected;
    if (item.isSelected && (item.totalquantity == null || item.totalquantity == 0)) {
      item.totalquantity = 1; // Default quantity when selected
    }
    update();
  }

  void incrementQuantity(ProductModel item) {
    item.totalquantity = (item.totalquantity ?? 0) + 1;
    item.textController!.text = item.totalquantity.toString();
    update();
  }

  void decrementQuantity(ProductModel item) {
    if ((item.totalquantity ?? 0) > 1) {
      item.totalquantity = (item.totalquantity ?? 0) - 1;
      item.textController!.text = item.totalquantity.toString();
    }
    update();
  }

  void updateQuantity(ProductModel item, num value) {
    item.totalquantity = value;
    update();
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }
}
