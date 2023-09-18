import 'Manager.dart';

/// id : 1
/// name : "Department5"
/// manager : {"id":5,"user_code":"00005","name":"diaasd","email":"asdsds@gmail.com","phone":46463113,"status":"active","user_type":"manager"}

class Data {
  Data({
      this.id, 
      this.name, 
      this.manager,});

  Data.fromJson(dynamic json) {
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