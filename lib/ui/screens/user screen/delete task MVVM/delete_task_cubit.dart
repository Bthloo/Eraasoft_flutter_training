import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../api/api_manager.dart';
import 'delete_task_states.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskViewState>{
  DeleteTaskCubit(): super(DeleteTaskInitialState());
  Future<void> deleteTask({required String token,required int taskId}) async {
    emit(DeleteTaskLoadingState());
    try{
      var response = await ApiManager.deleteTask(token: token,taskId: taskId);
      emit(DeleteTaskSuccessState(response));
    }on TimeoutException catch (ex) {
      emit(DeleteTaskFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit(DeleteTaskFailState('$ex'));
    }
  }
}