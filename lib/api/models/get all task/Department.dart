import 'Manager.dart';

/// id : 1
/// name : "khalid porad"
/// manager : {"id":143,"user_code":"00143","name":"diaa","email":"test@gmail.com","phone":1154951688,"status":"active","user_type":"manager","department_id":1}

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