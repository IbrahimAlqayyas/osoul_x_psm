class WorkOrderModel {
  String? recordType;
  String? id;
  WorkOrderValues? values;

  WorkOrderModel({this.recordType, this.id, this.values});

  WorkOrderModel.fromJson(Map<String, dynamic> json) {
    recordType = json['recordType'];
    id = json['id'];
    values = json['values'] != null ? new WorkOrderValues.fromJson(json['values']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordType'] = this.recordType;
    data['id'] = this.id;
    if (this.values != null) {
      data['values'] = this.values!.toJson();
    }
    return data;
  }
}

class WorkOrderValues {
  List<InternalObject>? internalid;
  String? name;
  String? custrecordPsmFinishWoProductionDate;
  List<InternalObject>? custrecordPsmFinishWo;

  WorkOrderValues({
    this.internalid,
    this.name,
    this.custrecordPsmFinishWoProductionDate,
    this.custrecordPsmFinishWo,
  });

  WorkOrderValues.fromJson(Map<String, dynamic> json) {
    if (json['internalid'] != null) {
      internalid = <InternalObject>[];
      json['internalid'].forEach((v) {
        internalid!.add(new InternalObject.fromJson(v));
      });
    }
    name = json['name'];
    custrecordPsmFinishWoProductionDate = json['custrecord_psm_finish_wo_production_date'];
    if (json['custrecord_psm_finish_wo'] != null) {
      custrecordPsmFinishWo = <InternalObject>[];
      json['custrecord_psm_finish_wo'].forEach((v) {
        custrecordPsmFinishWo!.add(new InternalObject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.internalid != null) {
      data['internalid'] = this.internalid!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['custrecord_psm_finish_wo_production_date'] = this.custrecordPsmFinishWoProductionDate;
    if (this.custrecordPsmFinishWo != null) {
      data['custrecord_psm_finish_wo'] = this.custrecordPsmFinishWo!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class InternalObject {
  String? value;
  String? text;

  InternalObject({this.value, this.text});

  InternalObject.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    return data;
  }
}
