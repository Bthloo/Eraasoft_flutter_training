
import '../../../../api/models/create user/CreateUserResponse.dart';
abstract class CreateUserViewState{}
class CreateUserInitialState extends CreateUserViewState {}
class CreateUserLoadingState extends CreateUserViewState{}
class CreateUserSuccessState extends CreateUserViewState{
CreateUserResponse createUserResponse;
CreateUserSuccessState(this.createUserResponse);
}
class CreateUserFailState extends CreateUserViewState{
  String message;
  CreateUserFailState(this.message);
}