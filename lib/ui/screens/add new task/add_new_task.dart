import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:task_management_erra_soft_training/ui/screens/add%20new%20task/add%20new%20task%20MVVM/add_new_task_cubit.dart';

import '../../../providers/auth_provider.dart';
import '../../components/custom_form_field.dart';
import '../../components/department_drop_down_menue.dart';
import '../../components/dialog.dart';
import '../../components/drop_menue.dart';
import '../home screen/home_screen.dart';
import '../update department/get all department MVVM/get_all_department_cubit.dart';
import '../update department/get all department MVVM/get_all_department_states.dart';
import '../update user/get all user MVVM/get_all_users_states.dart';
import '../update user/get all user MVVM/get_users_cubit.dart';
import 'add new task MVVM/add_new_task_states.dart';

class AddNewTask extends StatelessWidget {
  AddNewTask({super.key});
  static const routeName = "AddNewTask";
  final titleController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  var getAllDepartment = GetAllDepartmentCubit();
  var getAllUserViewModel = GetAllUsersCubit();
  var addNewTaskViewModel = AddNewTaskCubit();
  SingleValueDropDownController usersController =
      SingleValueDropDownController();
  DateRangePickerController datePikerController = DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider =
        Provider.of<AuthProvider>(context, listen: false);
    getAllUserViewModel.getAllUsers(token: userProvider.token ?? '');

    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formkey,
            child: BlocConsumer<AddNewTaskCubit, AddNewTaskViewState>(
                bloc: addNewTaskViewModel,
                listenWhen: (previous, current) {
                  if (previous is AddNewTaskLoadingState) {
                    DialogUtilities.hideDialog(context);
                  }
                  if (current is AddNewTaskSuccessState ||
                      current is AddNewTaskLoadingState ||
                      current is AddNewTaskFailState) {
                    return true;
                  }
                  return false;
                },
                buildWhen: (previous, current) {
                  if (current is AddNewTaskInitialState) return true;
                  return false;
                },
                listener: (context, state) {
                  // event
                  if(state is AddNewTaskFailState) {
                    // show message
                    DialogUtilities.showMessage(context, state.message,
                        posstiveActionName: "ok");
                  }
                  else if(state is AddNewTaskLoadingState) {
                    //show loading...
                    DialogUtilities.showLoadingDialog(context, "Loading...");
                  }
                  else if (state is AddNewTaskSuccessState) {
                    if (state.addNewTaskResponse.status == true) {
                      DialogUtilities.showMessage(context, state.addNewTaskResponse.message??'',
                          posstiveActionName: "ok", posstiveAction: () async {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeSceen.routeName);
                      });
                    }
                    else if (state.addNewTaskResponse.status == false) {
                      DialogUtilities.showMessage(
                        context,
                        state.addNewTaskResponse.message??'',
                        posstiveActionName: 'Ok',
                      );
                    }
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Add Task!',
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '''Create a new task now and assign it 
          to employees right away.''',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff7C808A)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SfDateRangePicker(
                            controller: datePikerController,
                            selectionColor: Color(0xff091E4A),
                            view: DateRangePickerView.month,
                            monthViewSettings: DateRangePickerMonthViewSettings(
                                firstDayOfWeek: 6),
                            selectionMode: DateRangePickerSelectionMode.range,
                            showActionButtons: true,
                            onCancel: () {}),
                        SizedBox(
                          height: 20,
                        ),
                        CustomFormField(
                          hintlText: "Title",
                          controller: titleController,
                          isPassword: false,
                          validator: (text) {
                            if (text!.length < 3 ||
                                text.trim().isEmpty ||
                                text.length > 20) {
                              return 'The Name Should be more than 3 char and less than 20 char';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomFormField(
                          hintlText: "Description",
                          controller: descriptionController,
                          isPassword: false,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please Enter Description';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<GetAllUsersCubit, GetAllUsersViewState>(
                          bloc: getAllUserViewModel,
                          builder: (context, state) {
                            if (state is GetAllUsersLoadingState) {
                              return CircularProgressIndicator();
                            } else if (state is GetAllUsersFailState) {
                              return Text(state.message);
                            } else if (state is GetAllUsersSuccessState) {
                              return DefaultDropDown(
                                controller: usersController,
                                list: state.getAllUsersResponse.data ?? [],
                                label: 'Select User',
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
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              addTask(userProvider.token??'');
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 17.0),
                              child: Text(
                                'Create',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
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
                  );
                }),
          ),
        ));
  }

  void addTask(String token) async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    addNewTaskViewModel.addNewTask(
        token: token,
        userId: '${usersController.dropDownValue?.value.toString()}',
        name: titleController.text,
        description: descriptionController.text,
        startDay:
            "${datePikerController.selectedRange?.startDate?.year}-${datePikerController.selectedRange?.startDate?.month}-${datePikerController.selectedRange?.startDate?.day}",
        endDate:
            "${datePikerController.selectedRange?.endDate?.year}-${datePikerController.selectedRange?.endDate?.month}-${datePikerController.selectedRange?.endDate?.day}");
    print("${datePikerController.selectedRange?.endDate?.year}-${datePikerController.selectedRange?.endDate?.month}-${datePikerController.selectedRange?.endDate?.day}");
  }
}
