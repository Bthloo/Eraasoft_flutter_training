
import 'package:task_management_erra_soft_training/api/models/add%20department/AddDepartmentResponse.dart';
import 'package:task_management_erra_soft_training/api/models/get%20all%20department/GetAllDepartmentResponse.dart';

import '../../../../api/models/add department/new/AddDepartmentResponsee.dart';
import '../../../../api/models/get manager model/GetAllManager.dart';
import '../../../../api/models/get manager model/new/GetAllManager.dart';

abstract class GetAllDepartmentViewState{}
class GetAllDepartmentInitialState extends GetAllDepartmentViewState {}
class GetAllDepartmentLoadingState extends GetAllDepartmentViewState{}
class GetAllDepartmentSuccessState extends GetAllDepartmentViewState{
  GetAllDepartmentResponse getAllDepartmentResponse;
  GetAllDepartmentSuccessState(this.getAllDepartmentResponse);
}
class GetAllDepartmentFailState extends GetAllDepartmentViewState{
  String message;
  GetAllDepartmentFailState(this.message);
}