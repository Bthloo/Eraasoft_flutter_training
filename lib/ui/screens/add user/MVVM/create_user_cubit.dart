import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_erra_soft_training/api/api_manager.dart';

import 'create_user_states.dart';

class CreateUserCubit extends Cubit<CreateUserViewState>{
  CreateUserCubit(): super(CreateUserInitialState());
  Future<void> createUser({required String email,
    required String password,
    required String name,
    required String phone,
    required String userType,
    required String token

  }) async {
    emit(CreateUserLoadingState());
    try{
      var response = await ApiManager.createUser(email: email,
          password: password,
          token: token,
          name: name,
          phone: phone,
          userType: userType,
      );
      emit(CreateUserSuccessState(response));
    }on TimeoutException catch (ex) {
    emit(CreateUserFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit(CreateUserFailState('$ex'));
    }
  }
}