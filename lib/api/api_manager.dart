import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:task_management_erra_soft_training/api/models/add%20department/new/AddDepartmentResponsee.dart';
import 'package:task_management_erra_soft_training/api/models/create%20user/CreateUserResponse.dart';
import 'package:task_management_erra_soft_training/api/models/get%20manager%20model/GetAllManager.dart';
import 'package:task_management_erra_soft_training/api/models/get%20manager%20model/new/GetAllManager.dart';
import '../ui/screens/add department/add_department.dart';
import 'models/add depart/AddDepartment.dart';
import 'models/add department/AddDepartmentResponse.dart';
import 'models/create user2/CreateUserr.dart';
import 'models/get all department/GetAllDepartmentResponse.dart';
import 'models/get all users/GetAllUsersResponse.dart';
import 'models/login model/LogInResponse.dart';
import 'models/logout model/LogoutResponse.dart';
import 'models/update depart/UpdateDepartmentResponse.dart';
import 'models/update department/UpdateDepartmentResponse.dart';
import 'models/update users/UpdateUsersResponse.dart';

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
static Future<AddDepartmentt>addDepartment({required String token,required String name}) async {
 var uri = Uri.https(baseUrl,'api/department/store',);
 var request = await http.post(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 },body: {
  'name' : name
 });

 var addDepartmentResponse =AddDepartmentt.fromJson(jsonDecode(request.body));
 return addDepartmentResponse;

}
static Future<GetAllManager>getAllManager({required String token}) async {
 var uri = Uri.https(baseUrl,'api/user/show-managers',);
 var request = await http.get(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 });

 var getAllManager = GetAllManager.fromJson(jsonDecode(request.body));
 return getAllManager;

}

static Future<CreateUserr>createUser({
 required String token,
 required String name,
 required String email,
 required String phone,
 required String password,
 required String userType,

}) async {
 var uri = Uri.https(baseUrl,'api/user/store',);
 var request = await http.post(uri,headers: {
  'Accept' : 'application/json',
  'Authorization' : "Bearer $token",
 // HttpHeaders.authorizationHeader : "Bearer $token"
 },body: {
  'name' : name,
  'email' : email,
  'password' : password,
  'phone' : phone,
  'user_type' : userType
 });

 var createUserResponse = CreateUserr.fromJson(jsonDecode(request.body));

 return createUserResponse;
}

static Future<GetAllDepartmentResponse>getAllDepartment({required String token}) async {
 var uri = Uri.https(baseUrl,'api/department/index',);
 var request = await http.get(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 });

 var getAllDepartment = GetAllDepartmentResponse.fromJson(jsonDecode(request.body));
 return getAllDepartment;

}


static Future<UpdateDepartResponse>updateDepartment({
 required String token,
 required String departmentName,
 required String managerId,
 //required String departmentId
}) async {
 var uri = Uri.https(baseUrl,'api/department/update/1',);
 var request = await http.post(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 },body: {
  'name' : "$departmentName",
  'manager_id' : '$managerId'
 });

 var updateDepartment = UpdateDepartResponse.fromJson(jsonDecode(request.body));
 return updateDepartment;

}


static Future<GetAllUsersResponse>getAllUsers({required String token}) async {
 var uri = Uri.https(baseUrl,'api/user/index',);
 var request = await http.get(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 });

 var getAllUsers = GetAllUsersResponse.fromJson(jsonDecode(request.body));
 return getAllUsers;

}


static Future<UpdateUsersResponse>updateUser({
 required String token,
 required int userId,
 required String departmentId,
 required String email,
 required String phone,
 required String password,
 required String usertype,
// required String userStatus,
 required String name


}) async {
 var uri = Uri.https(baseUrl,'api/user/update/$userId',);
 var request = await http.post(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 },body: {
  'name' : name,
  'email' : email,
  'user_status' : '0',
  'phone' : phone,
  'password' : password,
  'user_type' : usertype,
  'department_id' : departmentId

 });

 var updateUser = UpdateUsersResponse.fromJson(jsonDecode(request.body));
 return updateUser;

}

}