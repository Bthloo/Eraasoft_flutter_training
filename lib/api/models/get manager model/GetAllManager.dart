import 'Data.dart';

/// message : "OK"
/// data : [{"id":2,"user_code":"00002","name":"diaa","email":"h@h.com","phone":234324,"status":"active","user_type":"manager"},{"id":3,"user_code":"00003","name":"hossam","email":"hossam@h.com","phone":1234567,"status":"active","user_type":"manager"},{"id":5,"user_code":"00005","name":"diaa","email":"hd@h.com","phone":2343247,"status":"active","user_type":"manager"}]
/// status : true
/// code : 200

class llll {
  llll({
      this.message, 
      this.data, 
      this.status, 
      this.code,});

  llll.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ManagerDatann.fromJson(v));
      });
    }
    status = json['status'];
    code = json['code'];
  }
  String? message;
  List<ManagerDatann>? data;
  bool? status;
  int? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['code'] = code;
    return map;
  }

}