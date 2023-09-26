
import 'package:task_management_erra_soft_training/api/models/add%20new%20task/AddNewTaskResponse.dart';

import '../../../../api/models/update task/UpdateTaskResponse.dart';

abstract class UpdateTaskViewState{}
class  UpdateTaskInitialState extends UpdateTaskViewState {}
class  UpdateTaskLoadingState extends UpdateTaskViewState{}
class  UpdateTaskSuccessState extends UpdateTaskViewState{
  UpdateTaskResponse updateTaskResponse;
  UpdateTaskSuccessState(this.updateTaskResponse);
}
class  UpdateTaskFailState extends UpdateTaskViewState{
  String message;
  UpdateTaskFailState(this.message);
}