
import '../../../../api/models/delete task/DeleteTaskResponse.dart';

abstract class DeleteTaskViewState{}
class DeleteTaskInitialState extends DeleteTaskViewState {}
class DeleteTaskLoadingState extends DeleteTaskViewState{}
class DeleteTaskSuccessState extends DeleteTaskViewState{
  DeleteTaskResponse deleteTaskResponse;
  DeleteTaskSuccessState(this.deleteTaskResponse);
}
class DeleteTaskFailState extends DeleteTaskViewState{
  String message;
  DeleteTaskFailState(this.message);
}