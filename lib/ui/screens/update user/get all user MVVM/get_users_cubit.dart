
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../api/api_manager.dart';
import 'get_all_users_states.dart';

class GetAllUsersCubit extends Cubit<GetAllUsersViewState>{
  GetAllUsersCubit(): super(GetAllUsersInitialState());
  Future<void> getAllUsers({required String token}) async {
    emit(GetAllUsersLoadingState());
    try{
      var response = await ApiManager.getAllUsers(token: token);
      emit(GetAllUsersSuccessState(response));
    }on TimeoutException catch (ex) {
      emit(GetAllUsersFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit(GetAllUsersFailState('$ex'));
    }
  }
}