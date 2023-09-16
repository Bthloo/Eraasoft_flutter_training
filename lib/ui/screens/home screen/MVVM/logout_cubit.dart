import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_erra_soft_training/api/api_manager.dart';

import 'logout_states.dart';

class LogoutCubit extends Cubit<LogoutViewState>{
  LogoutCubit(): super(LogoutInitialState());
  Future<void> logout({required String token}) async {
    emit(LogoutLoadingState());
    try{
      var response = await ApiManager.logout(token);
      emit(LogoutSuccessState(response));
    }on TimeoutException catch (ex) {
    emit(LogoutFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit(LogoutFailState('$ex'));
    }
  }
}