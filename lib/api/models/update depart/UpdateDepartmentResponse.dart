import 'Data.dart';

/// message : "Updated Successfully"
/// data : {"id":1,"name":"Department5","manager":{"id":2,"user_code":"00002","name":"diaa","email":"m@m.com","phone":2222,"status":"ACTIVE","user_type":"MANAGER"}}
/// status : true
/// code : 200

class UpdateDepartResponse {
  UpdateDepartResponse({
      this.message, 
      this.data, 
      this.status, 
      this.code,});

  UpdateDepartResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    code = json['code'];
  }
  String? message;
  Data? data;
  bool? status;
  int? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['status'] = status;
    map['code'] = code;
    return map;
  }

}