import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_management_erra_soft_training/ui/screens/update%20department/get%20all%20department%20MVVM/get_all_department_cubit.dart';
import 'package:task_management_erra_soft_training/ui/screens/update%20department/update%20department%20MVVM/updatel_department_cubit.dart';
import 'package:task_management_erra_soft_training/ui/screens/update%20department/update%20department%20MVVM/updatel_department_states.dart';
import '../../../providers/auth_provider.dart';
import '../../components/department_drop_down_menue.dart';
import '../../components/dialog.dart';
import '../../components/manager_drop_down.dart';
import '../home screen/home_screen.dart';
import 'get all department MVVM/get_all_department_states.dart';
import 'get all mamager MVVM/get_all_manager_cubit.dart';
import 'get all mamager MVVM/get_all_managert_states.dart';

class UpdateDepartment extends StatelessWidget {
  UpdateDepartment({super.key});
  static const String routeName = 'updateDepartmentScreen';
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  SingleValueDropDownController managerController =
      SingleValueDropDownController();
  SingleValueDropDownController departmentNameController =
      SingleValueDropDownController();

  var updateDepartmentViewModel = UpdateDepartmentCubit();
  var getAllManagerViewModel = GetAllManagerCubit();
  var getAllDepartment = GetAllDepartmentCubit();
  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider =
        Provider.of<AuthProvider>(context, listen: false);
    getAllManagerViewModel.getAllManager(token: userProvider.token ?? "");
    getAllDepartment.getAllDepartment(token: userProvider.token ?? "");
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<UpdateDepartmentCubit, UpdateDepartmentViewState>(
          bloc: updateDepartmentViewModel,
          listenWhen: (previous, current) {
            if (previous is UpdateDepartmentLoadingState) {
              DialogUtilities.hideDialog(context);
            }
            if (current is UpdateDepartmentSuccessState ||
                current is UpdateDepartmentLoadingState ||
                current is UpdateDepartmentFailState) {
              return true;
            }
            return false;
          },
          buildWhen: (previous, current) {
            if (current is UpdateDepartmentInitialState) return true;
            return false;
          },
          listener: (context, state) {
            // event
            if (state is UpdateDepartmentFailState) {
              // show message
              DialogUtilities.showMessage(context, state.message,
                  posstiveActionName: "ok");
            } else if (state is UpdateDepartmentLoadingState) {
              //show loading...
              DialogUtilities.showLoadingDialog(context, "Loading...");
            } else if (state is UpdateDepartmentSuccessState) {
              if (state.updateDepartmentResponse.status == true) {
                DialogUtilities.showMessage(
                    context, state.updateDepartmentResponse.message ?? "",
                    posstiveActionName: "ok", posstiveAction: () async {
                  Navigator.of(context)
                      .pushReplacementNamed(HomeSceen.routeName);
                });
              } else if (state.updateDepartmentResponse.status == false) {
                DialogUtilities.showMessage(
                  context,
                  state.updateDepartmentResponse.message ?? '',
                  posstiveActionName: 'Ok',
                );
              }
              // show dialog
              // navigate to home screen
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ' Update Department!',
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '''Update department now and
assign a manager to start the work!''',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff7C808A)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<GetAllDepartmentCubit,
                          GetAllDepartmentViewState>(
                        bloc: getAllDepartment,
                        builder: (context, state) {
                          if (state is GetAllDepartmentLoadingState) {
                            return CircularProgressIndicator();
                          } else if (state is GetAllDepartmentFailState) {
                            return Text(state.message);
                          } else if (state is GetAllDepartmentSuccessState) {
                            return DepartmentDropDown(
                              controller: departmentNameController,
                              list: state.getAllDepartmentResponse.data ?? [],
                              label: 'Select Department',
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<GetAllManagerCubit, GetAllManagerViewState>(
                        bloc: getAllManagerViewModel,
                        builder: (context, state) {
                          if (state is GetAllManagerLoadingState) {
                            return CircularProgressIndicator();
                          } else if (state is GetAllManagerFailState) {
                            return Text(state.message);
                          } else if (state is GetAllManagerSuccessState) {
                            return ManagerDropDown(
                              controller: managerController,
                              list: state.getAllManagerResponse.data ?? [],
                              label: 'Assign Manager',
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            updateDepartment(userProvider.token ?? "");
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 17.0),
                            child: Text(
                              'Update',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).primaryColor),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4))))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  void updateDepartment(String token) async {
    if (formkey.currentState?.validate() == false) {
      return;
    }

    updateDepartmentViewModel.updateDepartment(
        token: token,
        // departmentId: departmentNameController.dropDownValue?.value,
        managerId: "${managerController.dropDownValue?.value}",
        departmentName: '${departmentNameController.dropDownValue?.name}');
  }
}

