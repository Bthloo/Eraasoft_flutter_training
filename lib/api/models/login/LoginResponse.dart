import 'Data.dart';

/// message : "Loggedin Successfuly."
/// data : {"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Rhc2tzYXBwLmludGVncmF0aW9uMjUuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNjk1MTQyNTcwLCJleHAiOjE2OTUxNDYxNzAsIm5iZiI6MTY5NTE0MjU3MCwianRpIjoiNVBHRTdnakRqS1l1TlhYeiIsInN1YiI6IjE0NCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.HgjV80XYpbbhcSr_6gNE_y0VFz0AlaZo-sl_1wTg6rA","username":"MAB","email":"mab@mab.mab","user_type":"admin"}
/// status : true
/// code : 200

class LoginResponse {
  LoginResponse({
      this.message, 
      this.data, 
      this.status, 
      this.code,});

  LoginResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
    status = json['status'];
    code = json['code'];
  }
  String? message;
  LoginData? data;
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