import 'package:flutter/material.dart';

class ProductModel {
  String? item;
  String? itemName;
  num? totalquantity;
  num? producedquantity;
  bool isSelected = false;
  TextEditingController? textController;

  ProductModel({
    this.item,
    this.itemName,
    this.totalquantity,
    this.producedquantity,
    this.isSelected = false,
    this.textController,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    itemName = json['itemname'];
    totalquantity = json['totalquantity'] != null && json['totalquantity'] != '' ? num.parse(json['totalquantity']) : 0;
    producedquantity = json['prducedquantity'] != null && json['prducedquantity'] != '' ? num.parse(json['prducedquantity']) : 0;
    isSelected = false;
    textController = TextEditingController(text: totalquantity.toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item'] = this.item;
    data['itemname'] = this.itemName;
    data['totalquantity'] = this.totalquantity;
    data['prducedquantity'] = this.producedquantity;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
