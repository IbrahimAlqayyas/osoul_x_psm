import 'package:flutter/material.dart';

class ItemToAddInTransferOrderModel {
  String? id;
  String? code;
  String? name;
  num? quantity;
  bool isSelected = false;
  TextEditingController? textController;

  ItemToAddInTransferOrderModel({
    this.id,
    this.code,
    this.name,
    this.quantity,
    this.isSelected = false,
    this.textController,
  });

  ItemToAddInTransferOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    quantity = json['quantity'] ?? 1;
    isSelected = false;
    textController = TextEditingController(text: quantity.toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
