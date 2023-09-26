
import '../../../../api/models/delete department/delete_department_response.dart';
import '../../../../api/models/delete task/DeleteTaskResponse.dart';

abstract class DeleteDepartmentViewState{}
class DeleteDepartmentInitialState extends DeleteDepartmentViewState {}
class DeleteDepartmentLoadingState extends DeleteDepartmentViewState{}
class DeleteDepartmentSuccessState extends DeleteDepartmentViewState{
  DeleteDepartmentResponse deleteDepartmentResponse;
  DeleteDepartmentSuccessState(this.deleteDepartmentResponse);
}
class DeleteDepartmentFailState extends DeleteDepartmentViewState{
  String message;
  DeleteDepartmentFailState(this.message);
}