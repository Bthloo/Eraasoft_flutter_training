import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:task_management_erra_soft_training/api/models/add%20department/new/AddDepartmentResponsee.dart';
import 'package:task_management_erra_soft_training/api/models/add%20new%20task/AddNewTaskResponse.dart';
import 'package:task_management_erra_soft_training/api/models/create%20user/CreateUserResponse.dart';
import 'package:task_management_erra_soft_training/api/models/get%20manager%20model/GetAllManager.dart';
import 'package:task_management_erra_soft_training/api/models/get%20manager%20model/new/GetAllManager.dart';
import '../ui/screens/add department/add_department.dart';
import 'models/add depart/AddDepartment.dart';
import 'models/add department/AddDepartmentResponse.dart';
import 'models/create user2/CreateUserr.dart';
import 'models/delete department/delete_department_response.dart';
import 'models/delete task/DeleteTaskResponse.dart';
import 'models/get all department/GetAllDepartmentResponse.dart';
import 'models/get all task/GetTaskResponse.dart';
import 'models/get all tasks/GetAllTasksResponse.dart';
import 'models/get all users/GetAllUsersResponse.dart';
import 'models/login model/LogInResponse.dart';
import 'models/login/LoginResponse.dart';
import 'models/logout model/LogoutResponse.dart';
import 'models/update depart/UpdateDepartmentResponse.dart';
import 'models/update department/UpdateDepartmentResponse.dart';
import 'models/update task/UpdateTaskResponse.dart';
import 'models/update users/UpdateUsersResponse.dart';

 class ApiManager{
static const String baseUrl = 'tasksapp.integration25.com';
static Future<LoginResponse>login({required String email,required String password}) async {
var uri = Uri.https(baseUrl,'api/auth/login');
 var request = await http.post(uri,body:{
  'email' : email,
  'password' : password
});
 
 var loginResponse = LoginResponse.fromJson(jsonDecode(request.body));
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


static Future<AddNewTaskResponse>addNewTask({
 required String token,
 required String userId,
 required String description,
 required String name,
 required String startDate,
 required String endDate,
}) async {
 var uri = Uri.https(baseUrl,'api/task/store',);
 var request = await http.post(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 },body: {
  'name' : '$name',
  'description' : "$description",
  'status' : '0',
  'employee_id' : "5",
  'start_date' : '$startDate',
  'end_date' : '$endDate',

 });

 var addNewTask = AddNewTaskResponse.fromJson(jsonDecode(request.body));
 return addNewTask;

}




static Future<GetTaskResponse>getAllTasks({required String token}) async {
 var uri = Uri.https(baseUrl,'api/task/index',);
 var request = await http.get(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 });

 var getAllTasks = GetTaskResponse.fromJson(jsonDecode(request.body));
 return getAllTasks;

}




static Future<DeleteTaskResponse>deleteTask({required String token,required int taskId}) async {
 var uri = Uri.https(baseUrl,'api/task/delete/$taskId',);
 var request = await http.delete(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 });

 var deleteTask = DeleteTaskResponse.fromJson(jsonDecode(request.body));
 return deleteTask;

}

static Future<DeleteDepartmentResponse>deleteDepartment({required String token,required int departmentId}) async {
 var uri = Uri.https(baseUrl,'api/department/delete/$departmentId',);
 var request = await http.delete(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 });

 var deleteDepartment = DeleteDepartmentResponse.fromJson(jsonDecode(request.body));
 return deleteDepartment;

}


static Future<DeleteDepartmentResponse>deleteUser({required String token,required int userId}) async {
 var uri = Uri.https(baseUrl,'api/user/delete/$userId',);
 var request = await http.delete(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 });

 var deleteDepartment = DeleteDepartmentResponse.fromJson(jsonDecode(request.body));
 return deleteDepartment;

}




static Future<UpdateTaskResponse>updateTask({
 required String token,
 required String userId,
 required String description,
 required String name,
 required String startDate,
 required String endDate,
 required int taskId
}) async {
 var uri = Uri.https(baseUrl,'api/task/update/$taskId',);
 var request = await http.post(uri,headers: {
  HttpHeaders.authorizationHeader : "Bearer $token"
 },body: {
  'name' : '$name',
  'description' : "$description",
  'status' : '0',
  'employee_id' : "5",
  'start_date' : '$startDate',
  'end_date' : '$endDate',

 });

 var updateTask = UpdateTaskResponse.fromJson(jsonDecode(request.body));
 return updateTask;

}


}