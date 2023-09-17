/// id : 38
/// user_code : "00038"
/// name : "omar"
/// email : "o@o.com"
/// phone : 23432425
/// status : "active"
/// user_type : "manager"

class Manager {
  Manager({
      this.id, 
      this.userCode, 
      this.name, 
      this.email, 
      this.phone, 
      this.status, 
      this.userType,});

  Manager.fromJson(dynamic json) {
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