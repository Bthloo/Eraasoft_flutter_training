
import '../../../../api/models/delete department/delete_department_response.dart';
import '../../../../api/models/delete task/DeleteTaskResponse.dart';

abstract class DeleteUserViewState{}
class DeleteUserInitialState extends DeleteUserViewState {}
class DeleteUserLoadingState extends DeleteUserViewState{}
class DeleteUserSuccessState extends DeleteUserViewState{
  DeleteDepartmentResponse deleteUserResponse;
  DeleteUserSuccessState(this.deleteUserResponse);
}
class DeleteUserFailState extends DeleteUserViewState{
  String message;
  DeleteUserFailState(this.message);
}