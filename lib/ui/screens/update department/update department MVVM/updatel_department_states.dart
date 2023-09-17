
import 'package:task_management_erra_soft_training/api/models/add%20department/AddDepartmentResponse.dart';
import 'package:task_management_erra_soft_training/api/models/get%20all%20department/GetAllDepartmentResponse.dart';

import '../../../../api/models/add department/new/AddDepartmentResponsee.dart';
import '../../../../api/models/get manager model/GetAllManager.dart';
import '../../../../api/models/get manager model/new/GetAllManager.dart';
import '../../../../api/models/update department/UpdateDepartmentResponse.dart';

abstract class UpdateDepartmentViewState{}
class UpdateDepartmentInitialState extends UpdateDepartmentViewState {}
class UpdateDepartmentLoadingState extends UpdateDepartmentViewState{}
class UpdateDepartmentSuccessState extends UpdateDepartmentViewState{
  UpdateDepartmentResponse updateDepartmentResponse;
  UpdateDepartmentSuccessState(this.updateDepartmentResponse);
}
class UpdateDepartmentFailState extends UpdateDepartmentViewState{
  String message;
  UpdateDepartmentFailState(this.message);
}