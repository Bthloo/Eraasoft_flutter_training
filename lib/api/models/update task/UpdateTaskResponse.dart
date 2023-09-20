import 'UpdateTaskData.dart';

/// message : "Updated Successfully"
/// updateTaskData : {"id":1,"name":"Task Test","description":"test description","photo":"http://127.0.0.1:8000","status":"NEW","start date":"2024-01-01","end date":"2024-01-01","creator":{"id":2,"user_code":"00002","name":"diaa","email":"m@m.com","phone":2222,"status":"ACTIVE","user_type":"MANAGER"},"department":{"id":2,"name":"Fuga.","manager":{"id":6,"user_code":"00006","name":"diaa","email":"h@h.com","phone":234324,"status":"ACTIVE","user_type":"MANAGER"}},"employee":{"id":4,"user_code":"00004","name":"diaa","email":"f@f.com","phone":4444,"status":"ACTIVE","user_type":"EMPLOYEE"}}
/// status : true
/// code : 200

class UpdateTaskResponse {
  UpdateTaskResponse({
      this.message, 
      this.updateTaskData, 
      this.status, 
      this.code,});

  UpdateTaskResponse.fromJson(dynamic json) {
    message = json['message'];
    updateTaskData = json['updateTaskData'] != null ? UpdateTaskData.fromJson(json['updateTaskData']) : null;
    status = json['status'];
    code = json['code'];
  }
  String? message;
  UpdateTaskData? updateTaskData;
  bool? status;
  int? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (updateTaskData != null) {
      map['updateTaskData'] = updateTaskData?.toJson();
    }
    map['status'] = status;
    map['code'] = code;
    return map;
  }

}