import 'Manager.dart';

/// id : 2
/// name : "Fuga."
/// manager : {"id":6,"user_code":"00006","name":"diaa","email":"h@h.com","phone":234324,"status":"ACTIVE","user_type":"MANAGER"}

class Department {
  Department({
      this.id, 
      this.name, 
      this.manager,});

  Department.fromJson(dynamic json) {
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