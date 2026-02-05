class UserModel {
  bool? access;
  String? status;
  String? statusname;
  bool? changePassword;
  bool? changePassRequired;
  String? driverid;
  String? vanid;
  String? drivername;
  String? email;
  String? picture;
  bool? hasFrozenItems;
  bool? hasFreshItems;

  UserModel({
    this.access,
    this.status,
    this.statusname,
    this.changePassword,
    this.changePassRequired,
    this.driverid,
    this.vanid,
    this.drivername,
    this.email,
    this.picture,
    this.hasFrozenItems,
    this.hasFreshItems,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    status = json['status'];
    statusname = json['statusname'];
    changePassword = json['ChangePassword'];
    changePassRequired = json['changePassRequired'];
    driverid = json['driverid'];
    vanid = json['vanid'];
    drivername = json['drivername'];
    email = json['email'];
    picture = json['picture'];
    hasFrozenItems = json['hasfrozenitems'];
    hasFreshItems = json['hasfreshitems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    data['status'] = status;
    data['statusname'] = statusname;
    data['ChangePassword'] = changePassword;
    data['changePassRequired'] = changePassRequired;
    data['driverid'] = driverid;
    data['vanid'] = vanid;
    data['drivername'] = drivername;
    data['email'] = email;
    data['picture'] = picture;
    data['hasfrozenitems'] = hasFrozenItems;
    data['hasfreshitems'] = hasFreshItems;
    return data;
  }
}
