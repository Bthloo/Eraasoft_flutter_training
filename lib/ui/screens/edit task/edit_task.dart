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
import '../user screen/user_screen.dart';
import 'edit task MVVM/edit_task_cubit.dart';
import 'edit task MVVM/edit_task_states.dart';

class EditTask extends StatefulWidget {
  EditTask({super.key});
  static const routeName = "editTask";

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  String userDropDownInitial = '';
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dropDownName = '';
  var dropDownId = 0;
  //late TextEditingController nameController;
 SingleValueDropDownController usersController = SingleValueDropDownController();
 // late SingleValueDropDownController usersController;
   DateRangePickerController datePikerController =DateRangePickerController();
  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      Arrgs arrgs = ModalRoute.of(context)!.settings.arguments as Arrgs;
      dropDownName = arrgs.getTasksData[arrgs.index].employee?.name??'';
      dropDownId = arrgs.getTasksData[arrgs.index].employee?.id??-1;
      usersController =  usersController.setDropDown(DropDownValueModel(name: dropDownName, value: dropDownId));

      titleController.text = arrgs.getTasksData[arrgs.index].name??'rrr';
      descriptionController.text = arrgs.getTasksData[arrgs.index].description??"";

    });



    super.initState();
  }

  final formkey = GlobalKey<FormState>();



  var getAllDepartment = GetAllDepartmentCubit();

  var getAllUserViewModel = GetAllUsersCubit();

  var updateTaskViewModel = UpdateTaskCubit();



  @override
  Widget build(BuildContext context) {



    Arrgs arrgs = ModalRoute.of(context)!.settings.arguments as Arrgs;
    AuthProvider userProvider =
    Provider.of<AuthProvider>(context, listen: false);
    getAllUserViewModel.getAllUsers(token: userProvider.token ?? '');
    titleController.text = arrgs.getTasksData[arrgs.index].name??'rrr';
    descriptionController.text = arrgs.getTasksData[arrgs.index].description??"";
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formkey,
            child: BlocConsumer<UpdateTaskCubit, UpdateTaskViewState>(
                bloc: updateTaskViewModel,
                listenWhen: (previous, current) {
                  if (previous is UpdateTaskLoadingState) {
                    DialogUtilities.hideDialog(context);
                  }
                  if (current is UpdateTaskSuccessState ||
                      current is UpdateTaskLoadingState ||
                      current is UpdateTaskFailState) {
                    return true;
                  }
                  return false;
                },
                buildWhen: (previous, current) {
                  if (current is UpdateTaskInitialState) return true;
                  return false;
                },
                listener: (context, state) {
                  // event
                  if (state is UpdateTaskFailState) {
                    // show message
                    DialogUtilities.showMessage(context, state.message,
                        posstiveActionName: "ok");
                  } else if (state is UpdateTaskLoadingState) {
                    //show loading...
                    DialogUtilities.showLoadingDialog(context, "Loading...");
                  } else if (state is UpdateTaskSuccessState) {
                    if (state.updateTaskResponse.status == true) {
                      DialogUtilities.showMessage(context, state.updateTaskResponse.message??'',
                          posstiveActionName: "ok", posstiveAction: () async {
                            Navigator.of(context)
                                .pushReplacementNamed(HomeSceen.routeName);
                          });
                    } else if (state.updateTaskResponse.status == false) {
                      DialogUtilities.showMessage(
                        context,
                        state.updateTaskResponse.message??'',
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
                          'Update Task!',
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '''Update a task now and assign it 
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
                        // SfDateRangePicker(
                        //     controller: datePikerController,
                        //     selectionColor: Color(0xff091E4A),
                        //     view: DateRangePickerView.month,
                        //     monthViewSettings: DateRangePickerMonthViewSettings(
                        //         firstDayOfWeek: 6),
                        //     selectionMode: DateRangePickerSelectionMode.range,
                        //     showActionButtons: true,
                        //     onCancel: () {}),
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
                               // initialValue: 'userDropDownInitia',
                                controller:usersController,
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
                              //addTask(userProvider.token??'',2);
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 17.0),
                              child: Text(
                                'Update',
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
  //
  // void addTask(String token,int taskId) async {
  //   if (formkey.currentState?.validate() == false) {
  //     return;
  //   }
  //   updateTaskViewModel.updateTask(
  //     taskId: taskId,
  //       token: token,
  //       userId: '${usersController.dropDownValue?.value.toString()}',
  //       name: titleController.text,
  //       description: descriptionController.text,
  //       startDay:
  //       "${datePikerController.selectedRange?.startDate?.year}-${datePikerController.selectedRange?.startDate?.month}-${datePikerController.selectedRange?.startDate?.day}",
  //       endDate:
  //       "${datePikerController.selectedRange?.endDate?.year}-${datePikerController.selectedRange?.endDate?.month}-${datePikerController.selectedRange?.endDate?.day}");
  //   print("${datePikerController.selectedRange?.endDate?.year}-${datePikerController.selectedRange?.endDate?.month}-${datePikerController.selectedRange?.endDate?.day}");
  // }
}
