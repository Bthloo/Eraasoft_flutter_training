import 'GetAllTasksdata.dart';

/// message : "OK"
/// getAllTasksdata : [{"id":1,"name":"Task Test","description":"test description","photo":"http://127.0.0.1:8000","status":"NEW","start date":"2024-01-01","end date":"2024-01-01","creator":{"id":2,"user_code":"00002","name":"diaa","email":"m@m.com","phone":2222,"status":"ACTIVE","user_type":"MANAGER"},"department":{"id":1,"name":"Department5","manager":{"id":2,"user_code":"00002","name":"diaa","email":"m@m.com","phone":2222,"status":"ACTIVE","user_type":"MANAGER"}},"employee":{"id":3,"user_code":"00003","name":"diaa","email":"e@e.com","phone":3333,"status":"ACTIVE","user_type":"EMPLOYEE"}}]
/// status : true
/// code : 200

class GetAllTasksResponse {
  GetAllTasksResponse({
      this.message, 
      this.getAllTasksdata, 
      this.status, 
      this.code,});

  GetAllTasksResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['getAllTasksdata'] != null) {
      getAllTasksdata = [];
      json['getAllTasksdata'].forEach((v) {
        getAllTasksdata?.add(GetAllTasksdata.fromJson(v));
      });
    }
    status = json['status'];
    code = json['code'];
  }
  String? message;
  List<GetAllTasksdata>? getAllTasksdata;
  bool? status;
  int? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (getAllTasksdata != null) {
      map['getAllTasksdata'] = getAllTasksdata?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['code'] = code;
    return map;
  }

}