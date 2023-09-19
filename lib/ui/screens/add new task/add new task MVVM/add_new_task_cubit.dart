import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_erra_soft_training/api/api_manager.dart';

import 'add_new_task_states.dart';


class AddNewTaskCubit extends Cubit<AddNewTaskViewState>{
  AddNewTaskCubit(): super(AddNewTaskInitialState());
  Future<void> addNewTask({
    required String name,
    required String userId,
    required String token,
    required String description,
    required String startDay,
    required String endDate,


  }) async {
    emit(AddNewTaskLoadingState());
    try{
    var response = await ApiManager.addNewTask(
      description: description,
      endDate: endDate,
      startDate: startDay,
      userId: userId,
      token: token,
      name: name,
    );
    emit(AddNewTaskSuccessState(response));
      }on TimeoutException catch (ex) {
      emit(AddNewTaskFailState('Please Check Your Internet\n $ex'));
      } catch (ex){
        emit(AddNewTaskFailState('$ex'));
      }
    }
  }
