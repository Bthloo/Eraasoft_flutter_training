import 'Data.dart';
import 'Faildata.dart';

/// message : "Created"
/// data : {"id":26,"user_code":"00026","name":"diaa","email":"h@hh.com","phone":1234324,"status":"active","user_type":"manager"}
/// faildata : {"failemail":["The email has already been taken."],"failphone":["The phone has already been taken."],"faildepartment_id":["This department already has manager."]}
/// status : true
/// code : 201

class CreateUserResponse {
  CreateUserResponse({
      this.message, 
      this.data, 
      this.faildata, 
      this.status, 
      this.code,});

  CreateUserResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    faildata = json['faildata'] != null ? Faildata.fromJson(json['faildata']) : null;
    status = json['status'];
    code = json['code'];
  }
  String? message;
  Data? data;
  Faildata? faildata;
  bool? status;
  int? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (faildata != null) {
      map['faildata'] = faildata?.toJson();
    }
    map['status'] = status;
    map['code'] = code;
    return map;
  }

}
enum UserTypes { admin, manager, user }