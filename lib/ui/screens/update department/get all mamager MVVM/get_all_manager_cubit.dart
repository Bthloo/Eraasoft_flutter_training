import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_erra_soft_training/api/api_manager.dart';

import 'get_all_managert_states.dart';

class GetAllManagerCubit extends Cubit<GetAllManagerViewState>{
  GetAllManagerCubit(): super(GetAllManagerInitialState());
  Future<void> getAllManager({required String token}) async {
    emit(GetAllManagerLoadingState());
    try{
      var response = await ApiManager.getAllManager(token: token);
      emit(GetAllManagerSuccessState(response));
    }on TimeoutException catch (ex) {
      emit(GetAllManagerFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit(GetAllManagerFailState('$ex'));
    }
  }
}