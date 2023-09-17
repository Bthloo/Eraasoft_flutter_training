import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_erra_soft_training/api/api_manager.dart';

import 'add_department_states.dart';

class AddDepartmentCubit extends Cubit<AddDepartmentViewState>{
  AddDepartmentCubit(): super(AddDepartmentInitialState());
  Future<void> addDepartment({required String name,required String token}) async {
    emit(AddDepartmentLoadingState());
    try{
      var response = await ApiManager.addDepartment(token: token, name: name);
      emit(AddDepartmentSuccessState(message: response.message,addDepartmentResponse: response));
    }on TimeoutException catch (ex) {
      emit(AddDepartmentFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit(AddDepartmentFailState('$ex'));
    }
  }
}