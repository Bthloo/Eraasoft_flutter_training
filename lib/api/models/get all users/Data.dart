/// id : 3
/// user_code : "00003"
/// name : "diaa"
/// email : "e@e.com"
/// phone : 3333
/// status : "ACTIVE"
/// user_type : "EMPLOYEE"

class AllUsersData {
  AllUsersData({
      this.id,
      this.userCode, 
      this.name, 
      this.email, 
      this.phone, 
      this.status, 
      this.userType,});

  AllUsersData.fromJson(dynamic json) {
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