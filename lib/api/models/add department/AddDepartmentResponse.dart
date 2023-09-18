import 'Data.dart';

/// message : "Created"
/// data : {"id":10,"name":"Department testh","manager":null}
/// status : true
/// code : 201

class AddDepartmentResponse {
  AddDepartmentResponse({
      this.message, 
      this.data, 
      this.status, 
      this.code,});

  AddDepartmentResponse.fromJson(dynamic json) {
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