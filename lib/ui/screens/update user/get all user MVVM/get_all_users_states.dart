
import '../../../../api/models/get all users/GetAllUsersResponse.dart';

abstract class GetAllUsersViewState{}
class GetAllUsersInitialState extends GetAllUsersViewState {}
class GetAllUsersLoadingState extends GetAllUsersViewState{}
class GetAllUsersSuccessState extends GetAllUsersViewState{
  GetAllUsersResponse getAllUsersResponse;
  GetAllUsersSuccessState(this.getAllUsersResponse);
}
class GetAllUsersFailState extends GetAllUsersViewState{
  String message;
  GetAllUsersFailState(this.message);
}