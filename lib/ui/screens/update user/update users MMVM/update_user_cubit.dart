
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_erra_soft_training/ui/screens/update%20user/update%20users%20MMVM/update_users_states.dart';

import '../../../../api/api_manager.dart';

class UpdateUsersCubit extends Cubit<UpdateUsersViewState>{
  UpdateUsersCubit(): super(UpdateUsersInitialState());
  Future<void> updateUser({required String token,
    required int userId,
    required String departmentId,
    required String name,
    required String email,
    required String phone,
    required String userType,
    required String password

  }) async {
    emit( UpdateUsersLoadingState());
    try{
      var response = await ApiManager.updateUser(
          token: token,
          departmentId: departmentId,
          userId: userId,
        name: name,
        password: password,
        email: email,
        phone: phone,
        usertype: userType,
      );
      emit( UpdateUsersSuccessState(response));
    }on TimeoutException catch (ex) {
      emit( UpdateUsersFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit( UpdateUsersFailState('$ex'));
    }
  }
}