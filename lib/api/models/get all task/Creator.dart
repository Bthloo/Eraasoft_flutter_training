/// id : 58
/// user_code : "00058"
/// name : "diaaf"
/// email : "admin@admin.com"
/// phone : 1010555
/// status : "active"
/// user_type : "admin"
/// department_id : 0

class Creator {
  Creator({
      this.id, 
      this.userCode, 
      this.name, 
      this.email, 
      this.phone, 
      this.status, 
      this.userType, 
      this.departmentId,});

  Creator.fromJson(dynamic json) {
    id = json['id'];
    userCode = json['user_code'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    userType = json['user_type'];
    departmentId = json['department_id'];
  }
  int? id;
  String? userCode;
  String? name;
  String? email;
  int? phone;
  String? status;
  String? userType;
  int? departmentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_code'] = userCode;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['status'] = status;
    map['user_type'] = userType;
    map['department_id'] = departmentId;
    return map;
  }

}