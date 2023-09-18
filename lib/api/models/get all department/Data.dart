import 'Manager.dart';

/// id : 1
/// name : "Depar"
/// manager : {"id":38,"user_code":"00038","name":"omar","email":"o@o.com","phone":23432425,"status":"active","user_type":"manager"}

class AllDepartmentData {
  AllDepartmentData({
      this.id, 
      this.name,
      this.manager,});

  AllDepartmentData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    manager = json['manager'] != null ? Manager.fromJson(json['manager']) : null;
  }
  int? id;
  String? name;
  Manager? manager;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (manager != null) {
      map['manager'] = manager?.toJson();
    }
    return map;
  }

}