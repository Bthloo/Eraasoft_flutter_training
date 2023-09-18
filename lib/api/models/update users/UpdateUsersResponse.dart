import 'UpdateUserdata.dart';

/// message : "Updated Successfully"
/// updateUserdata : {"id":5,"user_code":"00005","name":"diaa","email":"a@gmail.com","phone":2223,"status":"ACTIVE","user_type":"MANAGER"}
/// status : true
/// code : 200

class UpdateUsersResponse {
  UpdateUsersResponse({
      this.message, 
      this.updateUserdata, 
      this.status, 
      this.code,});

  UpdateUsersResponse.fromJson(dynamic json) {
    message = json['message'];
    updateUserdata = json['updateUserdata'] != null ? UpdateUserdata.fromJson(json['updateUserdata']) : null;
    status = json['status'];
    code = json['code'];
  }
  String? message;
  UpdateUserdata? updateUserdata;
  bool? status;
  int? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (updateUserdata != null) {
      map['updateUserdata'] = updateUserdata?.toJson();
    }
    map['status'] = status;
    map['code'] = code;
    return map;
  }

}