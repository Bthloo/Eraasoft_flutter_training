import '../../../../api/models/update users/UpdateUsersResponse.dart';

abstract class UpdateUsersViewState{}
class UpdateUsersInitialState extends UpdateUsersViewState {}
class UpdateUsersLoadingState extends UpdateUsersViewState{}
class UpdateUsersSuccessState extends UpdateUsersViewState{
  UpdateUsersResponse updateUsersResponse;
  UpdateUsersSuccessState(this.updateUsersResponse);
}
class UpdateUsersFailState extends UpdateUsersViewState{
  String message;
  UpdateUsersFailState(this.message);
}