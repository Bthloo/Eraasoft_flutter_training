/// id : 5
/// user_code : "00005"
/// name : "diaa"
/// email : "a@gmail.com"
/// phone : 2223
/// status : "ACTIVE"
/// user_type : "MANAGER"

class UpdateUserdata {
  UpdateUserdata({
      this.id,
      this.userCode, 
      this.name, 
      this.email, 
      this.phone, 
      this.status, 
      this.userType,});

  UpdateUserdata.fromJson(dynamic json) {
    id = json['id'];
    userCode = json['user_code'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    userType = json['user_type'];
  }
  int? id;
  String? userCode;
  String? name;
  String? email;
  int? phone;
  String? status;
  String? userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_code'] = userCode;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['status'] = status;
    map['user_type'] = userType;
    return map;
  }

}