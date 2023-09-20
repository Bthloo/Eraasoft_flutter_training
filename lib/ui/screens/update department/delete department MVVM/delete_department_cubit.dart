import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../api/api_manager.dart';
import 'delete_department_states.dart';

class DeleteDepartmentCubit extends Cubit<DeleteDepartmentViewState>{
  DeleteDepartmentCubit(): super(DeleteDepartmentInitialState());
  Future<void> deleteTask({required String token,required int taskId}) async {
    emit(DeleteDepartmentLoadingState());
    try{
      var response = await ApiManager.deleteDepartment(token: token,departmentId: taskId);
      emit(DeleteDepartmentSuccessState(response));
    }on TimeoutException catch (ex) {
      emit(DeleteDepartmentFailState('Please Check Your Internet\n $ex'));
    } catch (ex){
      emit(DeleteDepartmentFailState('$ex'));
    }
  }
}