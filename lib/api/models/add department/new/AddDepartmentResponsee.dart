import 'Successdata.dart';
import 'Faildata.dart';

/// message : "Created"
/// successdata : {"id":53,"name":"Department testhkkxx","manager":null}
/// faildata : {"name":["The name has already been taken."]}
/// status : true
/// code : 201

class AddDepartmentResponsee {
  AddDepartmentResponsee({
      this.message, 
      this.successdata,
      this.faildata, 
      this.status, 
      this.code,});

  AddDepartmentResponsee.fromJson(dynamic json) {
    message = json['message'];
    successdata = json['successdata'] != null ? Successdata.fromJson(json['successdata']) : null;
    faildata = json['faildata'] != null ? Faildata.fromJson(json['faildata']) : null;
    status = json['status'];
    code = json['code'];
  }
  String? message;
  Successdata? successdata;
  Faildata? faildata;
  bool? status;
  int? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (successdata != null) {
      map['successdata'] = successdata?.toJson();
    }
    if (faildata != null) {
      map['faildata'] = faildata?.toJson();
    }
    map['status'] = status;
    map['code'] = code;
    return map;
  }

}