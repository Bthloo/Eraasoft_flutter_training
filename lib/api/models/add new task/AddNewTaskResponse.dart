import 'AddTaskData.dart';

/// message : "Created"
/// addTaskData : {"id":3,"name":"Task Test","description":"test description","photo":"http://127.0.0.1:8000","status":"NEW","start date":"2024-01-01","end date":"2024-01-01","creator":{"id":1,"user_code":"00015","name":"Santos Powlowski V","email":"admin@admin.com","phone":1111,"status":"ACTIVE","user_type":"ADMIN"},"department":{"id":1,"name":"Department5","manager":{"id":2,"user_code":"00002","name":"diaa","email":"m@m.com","phone":2222,"status":"ACTIVE","user_type":"MANAGER"}},"employee":{"id":3,"user_code":"00003","name":"diaa","email":"e@e.com","phone":3333,"status":"ACTIVE","user_type":"EMPLOYEE"}}
/// status : true
/// code : 201

class AddNewTaskResponse {
  AddNewTaskResponse({
      this.message, 
      this.addTaskData, 
      this.status, 
      this.code,});

  AddNewTaskResponse.fromJson(dynamic json) {
    message = json['message'];
    addTaskData = json['addTaskData'] != null ? AddTaskData.fromJson(json['addTaskData']) : null;
    status = json['status'];
    code = json['code'];
  }
  String? message;
  AddTaskData? addTaskData;
  bool? status;
  int? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (addTaskData != null) {
      map['addTaskData'] = addTaskData?.toJson();
    }
    map['status'] = status;
    map['code'] = code;
    return map;
  }

}