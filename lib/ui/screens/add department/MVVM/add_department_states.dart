
import 'package:task_management_erra_soft_training/api/models/add%20department/AddDepartmentResponse.dart';

import '../../../../api/models/add depart/AddDepartment.dart';
import '../../../../api/models/add department/new/AddDepartmentResponsee.dart';

abstract class AddDepartmentViewState{}
class AddDepartmentInitialState extends AddDepartmentViewState {}
class AddDepartmentLoadingState extends AddDepartmentViewState{}
class AddDepartmentSuccessState extends AddDepartmentViewState{
  AddDepartmentt? addDepartmentResponse;
  String? message;
  AddDepartmentSuccessState({this.addDepartmentResponse, this.message});
}
class AddDepartmentFailState extends AddDepartmentViewState{
  String message;
  AddDepartmentFailState(this.message);
}