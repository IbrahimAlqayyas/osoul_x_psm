class WorkOrderItemLineModel {
  String? item;
  String? itemName;
  num? totalquantity;
  num? prducedquantity;

  WorkOrderItemLineModel({this.item, this.itemName, this.totalquantity, this.prducedquantity});

  WorkOrderItemLineModel.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    itemName = json['itemname'];
    totalquantity = json['totalquantity'] != null && json['totalquantity'] != ''
        ? num.parse(json['totalquantity'])
        : 0;
    prducedquantity = json['prducedquantity'] != null && json['prducedquantity'] != ''
        ? num.parse(json['prducedquantity'])
        : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['itemname'] = this.itemName;
    data['totalquantity'] = this.totalquantity;
    data['prducedquantity'] = this.prducedquantity;
    return data;
  }
}
