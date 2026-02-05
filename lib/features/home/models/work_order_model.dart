

class WorkOrderModel {
  String? id;
  String? productionDate;

  WorkOrderModel({this.id, this.productionDate});

  factory WorkOrderModel.fromJson(Map<String, dynamic> json) => WorkOrderModel(
    id: json['id'],
    productionDate: json['productionDate'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'productionDate': productionDate,
  };
}