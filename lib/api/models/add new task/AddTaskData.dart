import 'Creator.dart';
import 'Department.dart';
import 'Employee.dart';

/// id : 3
/// name : "Task Test"
/// description : "test description"
/// photo : "http://127.0.0.1:8000"
/// status : "NEW"
/// start date : "2024-01-01"
/// end date : "2024-01-01"
/// creator : {"id":1,"user_code":"00015","name":"Santos Powlowski V","email":"admin@admin.com","phone":1111,"status":"ACTIVE","user_type":"ADMIN"}
/// department : {"id":1,"name":"Department5","manager":{"id":2,"user_code":"00002","name":"diaa","email":"m@m.com","phone":2222,"status":"ACTIVE","user_type":"MANAGER"}}
/// employee : {"id":3,"user_code":"00003","name":"diaa","email":"e@e.com","phone":3333,"status":"ACTIVE","user_type":"EMPLOYEE"}

class AddTaskData {
  AddTaskData({
      this.id, 
      this.name, 
      this.description, 
      this.photo, 
      this.status, 
      this.startdate, 
      this.enddate, 
      this.creator, 
      this.department, 
      this.employee,});

  AddTaskData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    photo = json['photo'];
    status = json['status'];
    startdate = json['start date'];
    enddate = json['end date'];
    creator = json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    department = json['department'] != null ? Department.fromJson(json['department']) : null;
    employee = json['employee'] != null ? Employee.fromJson(json['employee']) : null;
  }
  int? id;
  String? name;
  String? description;
  String? photo;
  String? status;
  String? startdate;
  String? enddate;
  Creator? creator;
  Department? department;
  Employee? employee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['photo'] = photo;
    map['status'] = status;
    map['start date'] = startdate;
    map['end date'] = enddate;
    if (creator != null) {
      map['creator'] = creator?.toJson();
    }
    if (department != null) {
      map['department'] = department?.toJson();
    }
    if (employee != null) {
      map['employee'] = employee?.toJson();
    }
    return map;
  }

}