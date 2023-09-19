import 'Creator.dart';
import 'Department.dart';
import 'Employee.dart';

/// id : 1
/// name : "Task Tests"
/// description : "test descriptionsss"
/// photo : "https://tasksapp.integration25.com"
/// status : "new"
/// start date : "2024-01-01"
/// end date : "2024-01-01"
/// creator : {"id":58,"user_code":"00058","name":"diaaf","email":"admin@admin.com","phone":1010555,"status":"active","user_type":"admin","department_id":0}
/// department : {"id":1,"name":"khalid porad","manager":{"id":143,"user_code":"00143","name":"diaa","email":"test@gmail.com","phone":1154951688,"status":"active","user_type":"manager","department_id":1}}
/// employee : {"id":9,"user_code":"00009","name":"diaa","email":"bebo@gmail.com","phone":10147520,"status":"active","user_type":"employee","department_id":1}

class GetTaskData {
  GetTaskData({
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

  GetTaskData.fromJson(dynamic json) {
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