import 'Data.dart';

/// message : "Created"
/// data : {"id":129,"name":"Departme","manager":null}
/// status : true
/// code : 201

class AddDepartmentt {
  AddDepartmentt({
      this.message, 
      this.data, 
      this.status, 
      this.code,});

  AddDepartmentt.fromJson(dynamic json) {
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