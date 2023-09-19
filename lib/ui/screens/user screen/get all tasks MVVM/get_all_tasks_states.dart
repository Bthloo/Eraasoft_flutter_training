
import 'package:task_management_erra_soft_training/api/models/add%20department/AddDepartmentResponse.dart';
import 'package:task_management_erra_soft_training/api/models/get%20all%20tasks/GetAllTasksResponse.dart';

import '../../../../api/models/add department/new/AddDepartmentResponsee.dart';
import '../../../../api/models/get all task/GetTaskResponse.dart';
import '../../../../api/models/get manager model/GetAllManager.dart';
import '../../../../api/models/get manager model/new/GetAllManager.dart';

abstract class GetAllTasksViewState{}
class GetAllTasksInitialState extends GetAllTasksViewState {}
class GetAllTasksLoadingState extends GetAllTasksViewState{}
class GetAllTasksSuccessState extends GetAllTasksViewState{
  GetTaskResponse getAllTasksResponse;
  GetAllTasksSuccessState(this.getAllTasksResponse);
}
class GetAllTasksFailState extends GetAllTasksViewState{
  String message;
  GetAllTasksFailState(this.message);
}