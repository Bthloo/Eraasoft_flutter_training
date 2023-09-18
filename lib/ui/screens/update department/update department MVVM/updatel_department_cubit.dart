import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_erra_soft_training/api/api_manager.dart';

import 'updatel_department_states.dart';

class UpdateDepartmentCubit extends Cubit<UpdateDepartmentViewState>{
  UpdateDepartmentCubit(): super(UpdateDepartmentInitialState());
  Future<void> updateDepartment({required String token,
   required String departmentName,
    required String managerId,
   // required String departmentId
  }) async {
    emit( UpdateDepartmentLoadingState());
    try{
      var response = await ApiManager.updateDepartment(
          token: token,
          departmentName: departmentName,
         // departmentId: departmentId,
          managerId: managerId
      );
      emit( UpdateDepartmentSuccessState(response));
    }on TimeoutException catch (ex) {
      emit( UpdateDepartmentFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit( UpdateDepartmentFailState('$ex'));
    }
  }
}