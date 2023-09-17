/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Rhc2tzYXBwLmludGVncmF0aW9uMjUuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNjk0ODYwOTI4LCJleHAiOjE2OTQ4NjQ1MjgsIm5iZiI6MTY5NDg2MDkyOCwianRpIjoiSUJpYXpTQ2JyUUEyNmszRyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.x8akcb2le66KojQfrB__0zaZfZVxvg4Ppz0ibwCkbUA"
/// username : "Ms. Zelda Botsford I"
/// email : "admin@admin.com"
/// user_type : "admin"

class ManagerDatann {
  ManagerDatann({
      this.token,
      this.username, 
      this.email, 
      this.userType,});

  ManagerDatann.fromJson(dynamic json) {
    token = json['token'];
    username = json['username'];
    email = json['email'];
    userType = json['user_type'];
  }
  String? token;
  String? username;
  String? email;
  String? userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['username'] = username;
    map['email'] = email;
    map['user_type'] = userType;
    return map;
  }

}