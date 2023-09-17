import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_erra_soft_training/api/api_manager.dart';

import 'get_all_department_states.dart';

class GetAllDepartmentCubit extends Cubit<GetAllDepartmentViewState>{
  GetAllDepartmentCubit(): super(GetAllDepartmentInitialState());
  Future<void> getAllManager({required String token}) async {
    emit( GetAllDepartmentLoadingState());
    try{
      var response = await ApiManager.getAllDepartment(token: token);
      emit( GetAllDepartmentSuccessState(response));
    }on TimeoutException catch (ex) {
      emit( GetAllDepartmentFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit( GetAllDepartmentFailState('$ex'));
    }
  }
}