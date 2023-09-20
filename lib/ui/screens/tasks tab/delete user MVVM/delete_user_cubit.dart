import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../api/api_manager.dart';
import 'delete_user_states.dart';

class DeleteUserCubit extends Cubit<DeleteUserViewState>{
  DeleteUserCubit(): super(DeleteUserInitialState());
  Future<void> deleteUser({required String token,required int userId}) async {
    emit(DeleteUserLoadingState());
    try{
      var response = await ApiManager.deleteUser(token: token, userId: userId);
      emit(DeleteUserSuccessState(response));
    }on TimeoutException catch (ex) {
      emit(DeleteUserFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit(DeleteUserFailState('$ex'));
    }
  }
}