
import '../../../../api/models/create user/CreateUserResponse.dart';
import '../../../../api/models/create user2/CreateUserr.dart';
abstract class CreateUserViewState{}
class CreateUserInitialState extends CreateUserViewState {}
class CreateUserLoadingState extends CreateUserViewState{}
class CreateUserSuccessState extends CreateUserViewState{
  CreateUserr createUserResponse;
CreateUserSuccessState(this.createUserResponse);
}
class CreateUserFailState extends CreateUserViewState{
  String message;
  CreateUserFailState(this.message);
}