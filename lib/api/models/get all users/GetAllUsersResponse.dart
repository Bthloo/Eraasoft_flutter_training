import 'Data.dart';

/// message : "OK"
/// data : [{"id":3,"user_code":"00003","name":"diaa","email":"e@e.com","phone":3333,"status":"ACTIVE","user_type":"EMPLOYEE"},{"id":5,"user_code":"00005","name":"diaa","email":"g@g.com","phone":7656,"status":"ACTIVE","user_type":"EMPLOYEE"}]
/// status : true
/// code : 200

class GetAllUsersResponse {
  GetAllUsersResponse({
      this.message, 
      this.data,
      this.status, 
      this.code,});

  GetAllUsersResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AllUsersData.fromJson(v));
      });
    }
    status = json['status'];
    code = json['code'];
  }
  String? message;
  List<AllUsersData>? data;
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