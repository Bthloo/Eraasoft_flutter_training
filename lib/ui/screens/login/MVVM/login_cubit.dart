import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_erra_soft_training/api/api_manager.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginViewState>{
  LoginCubit(): super(LoginInitialState());
  Future<void> login({required String email,required String password}) async {
    emit(LoginLoadingState());
    try{
      var response = await ApiManager.login(email: email, password: password);
      emit(LoginSuccessState(response));
    }on TimeoutException catch (ex) {
    emit(LoginFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit(LoginFailState('$ex'));
    }
  }
}