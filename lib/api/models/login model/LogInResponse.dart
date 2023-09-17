import '../get manager model/Data.dart';

/// message : "Loggedin Successfuly"
/// data : {"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Rhc2tzYXBwLmludGVncmF0aW9uMjUuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNjk0ODYwOTI4LCJleHAiOjE2OTQ4NjQ1MjgsIm5iZiI6MTY5NDg2MDkyOCwianRpIjoiSUJpYXpTQ2JyUUEyNmszRyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.x8akcb2le66KojQfrB__0zaZfZVxvg4Ppz0ibwCkbUA","username":"Ms. Zelda Botsford I","email":"admin@admin.com","user_type":"admin"}
/// status : true
/// code : 200

class LogInResponse {
  LogInResponse({
      this.message, 
      this.data, 
      this.status, 
      this.code,});

  LogInResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? ManagerDatann.fromJson(json['data']) : null;
    status = json['status'];
    code = json['code'];
  }
  String? message;
  ManagerDatann? data;
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