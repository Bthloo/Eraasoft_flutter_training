import 'Data.dart';

/// message : "Created"
/// data : {"id":69,"user_code":"00069","name":"fgfdd","email":"lll@kl.com","phone":2823943,"status":"active","user_type":"manager"}
/// status : true
/// code : 201

class CreateUserr {
  CreateUserr({
      this.message, 
      this.data, 
      this.status, 
      this.code,});

  CreateUserr.fromJson(dynamic json) {
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