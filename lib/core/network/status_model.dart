class StatusModel<T> {
  Status? status;
  String? message;
  List<String>? errors;
  String? uuid;
  T? data;
  T? state;

  StatusModel({required this.status, this.message, this.data, this.uuid, this.state});

  Map<String, dynamic> toJson() {
    return {
      'status': status?.toString(),
      'message': message,
      'uuid': uuid,
      'data': data,
      'state': state,
      'errors': errors,
    };
  }
}

enum Status { succeeded, failed, error, unauthorized, unhandledFailure }

class Meta {
  int? page;
  int? limit;
  int? itemCount;
  int? pageCount;
  bool? hasPreviousPage;
  bool? hasNextPage;

  Meta({
    this.page,
    this.limit,
    this.itemCount,
    this.pageCount,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    itemCount = json['itemCount'];
    pageCount = json['pageCount'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['itemCount'] = itemCount;
    data['pageCount'] = pageCount;
    data['hasPreviousPage'] = hasPreviousPage;
    data['hasNextPage'] = hasNextPage;
    return data;
  }
}
