import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_erra_soft_training/api/api_manager.dart';
import 'edit_task_states.dart';


class UpdateTaskCubit extends Cubit<UpdateTaskViewState>{
  UpdateTaskCubit(): super(UpdateTaskInitialState());
  Future<void> updateTask({
    required String name,
    required String userId,
    required String token,
    required String description,
    required String startDay,
    required String endDate,
    required int taskId,


  }) async {
    emit(UpdateTaskLoadingState());
    try{
    var response = await ApiManager.updateTask(
      description: description,
      endDate: endDate,
      startDate: startDay,
      userId: userId,
      token: token,
      name: name,
      taskId: taskId
    );
    emit(UpdateTaskSuccessState(response));
      }on TimeoutException catch (ex) {
      emit(UpdateTaskFailState('Please Check Your Internet\n $ex'));
      } catch (ex){
        emit(UpdateTaskFailState('$ex'));
      }
    }
  }
