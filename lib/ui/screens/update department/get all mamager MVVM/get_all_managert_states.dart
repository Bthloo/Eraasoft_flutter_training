
import 'package:task_management_erra_soft_training/api/models/add%20department/AddDepartmentResponse.dart';

import '../../../../api/models/add department/new/AddDepartmentResponsee.dart';
import '../../../../api/models/get manager model/GetAllManager.dart';
import '../../../../api/models/get manager model/new/GetAllManager.dart';

abstract class GetAllManagerViewState{}
class GetAllManagerInitialState extends GetAllManagerViewState {}
class GetAllManagerLoadingState extends GetAllManagerViewState{}
class GetAllManagerSuccessState extends GetAllManagerViewState{
  GetAllManager getAllManagerResponse;
  GetAllManagerSuccessState(this.getAllManagerResponse);
}
class GetAllManagerFailState extends GetAllManagerViewState{
  String message;
  GetAllManagerFailState(this.message);
}