/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Rhc2tzYXBwLmludGVncmF0aW9uMjUuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNjk1MTQyNTcwLCJleHAiOjE2OTUxNDYxNzAsIm5iZiI6MTY5NTE0MjU3MCwianRpIjoiNVBHRTdnakRqS1l1TlhYeiIsInN1YiI6IjE0NCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.HgjV80XYpbbhcSr_6gNE_y0VFz0AlaZo-sl_1wTg6rA"
/// username : "MAB"
/// email : "mab@mab.mab"
/// user_type : "admin"

class LoginData {
  LoginData({
      this.token, 
      this.username, 
      this.email, 
      this.userType,});

  LoginData.fromJson(dynamic json) {
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