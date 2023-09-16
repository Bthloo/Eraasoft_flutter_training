import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'models/login model/LogInResponse.dart';
import 'models/logout model/LogoutResponse.dart';

 class ApiManager{
static const String baseUrl = 'tasksapp.integration25.com';
static Future<LogInResponse>login({required String email,required String password}) async {
var uri = Uri.https(baseUrl,'api/auth/login');
 var request = await http.post(uri,body:{
  'email' : email,
  'password' : password
});
 
 var loginResponse = LogInResponse.fromJson(jsonDecode(request.body));
 return loginResponse;

}
static Future<LogoutResponse>logout(String token) async {
 var uri = Uri.https(baseUrl,'api/auth/logout',);
 var request = await http.post(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 });

 var logoutResponse = LogoutResponse.fromJson(jsonDecode(request.body));
 return logoutResponse;

}
}