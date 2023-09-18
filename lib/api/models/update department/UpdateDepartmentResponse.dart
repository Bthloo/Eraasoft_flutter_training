import 'Data.dart';

/// message : "Updated Successfully."
/// data : {"id":1,"name":"Department5","manager":{"id":5,"user_code":"00005","name":"diaasd","email":"asdsds@gmail.com","phone":46463113,"status":"active","user_type":"manager"}}
/// status : true
/// code : 200

class UpdateDepartmentResponse {
  UpdateDepartmentResponse({
      this.message, 
      this.data, 
      this.status,
      this.code,});

  UpdateDepartmentResponse.fromJson(dynamic json) {
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