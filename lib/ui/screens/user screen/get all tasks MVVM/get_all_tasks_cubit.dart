import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_erra_soft_training/api/api_manager.dart';

import 'get_all_tasks_states.dart';

class GetAllTasksCubit extends Cubit<GetAllTasksViewState>{
  GetAllTasksCubit(): super(GetAllTasksInitialState());
  Future<void> getAllTasks({required String token}) async {
    emit(GetAllTasksLoadingState());
    try{
      var response = await ApiManager.getAllTasks(token: token);
      emit(GetAllTasksSuccessState(response));
    }on TimeoutException catch (ex) {
      emit(GetAllTasksFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit(GetAllTasksFailState('$ex'));
    }
  }
}