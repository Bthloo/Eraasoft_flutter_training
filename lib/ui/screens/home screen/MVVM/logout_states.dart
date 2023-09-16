
import '../../../../api/models/login model/LogInResponse.dart';
import '../../../../api/models/logout model/LogoutResponse.dart';

abstract class LogoutViewState{}
class LogoutInitialState extends LogoutViewState {}
class LogoutLoadingState extends LogoutViewState{}
class LogoutSuccessState extends LogoutViewState{
  LogoutResponse logoutResponse;
  LogoutSuccessState(this.logoutResponse);
}
class LogoutFailState extends LogoutViewState{
  String message;
  LogoutFailState(this.message);
}