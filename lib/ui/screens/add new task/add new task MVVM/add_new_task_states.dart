
import 'package:task_management_erra_soft_training/api/models/add%20new%20task/AddNewTaskResponse.dart';

abstract class AddNewTaskViewState{}
class AddNewTaskInitialState extends AddNewTaskViewState {}
class AddNewTaskLoadingState extends AddNewTaskViewState{}
class AddNewTaskSuccessState extends AddNewTaskViewState{
  AddNewTaskResponse addNewTaskResponse;
  AddNewTaskSuccessState(this.addNewTaskResponse);
}
class AddNewTaskFailState extends AddNewTaskViewState{
  String message;
  AddNewTaskFailState(this.message);
}