
import '../../../../api/models/login model/LogInResponse.dart';
import '../../../../api/models/login/LoginResponse.dart';

abstract class LoginViewState{}
class LoginInitialState extends LoginViewState {}
class LoginLoadingState extends LoginViewState{}
class LoginSuccessState extends LoginViewState{
  LoginResponse logInResponse;
  LoginSuccessState(this.logInResponse);
}
class LoginFailState extends LoginViewState{
  String message;
  LoginFailState(this.message);
}