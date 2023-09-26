
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:task_management_erra_soft_training/ui/components/custom_form_field.dart';
import 'package:task_management_erra_soft_training/ui/screens/task%20details/task_status.dart';
import 'package:task_management_erra_soft_training/ui/screens/user%20screen/user_screen.dart';

import '../../../api/models/create user/CreateUserResponse.dart';
import '../../../providers/auth_provider.dart';
import '../../components/dialog.dart';
import '../edit task/edit task MVVM/edit_task_cubit.dart';
import '../edit task/edit task MVVM/edit_task_states.dart';
import '../home screen/home_screen.dart';
import '../user screen/get all tasks MVVM/get_all_tasks_states.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});
static const String routeName = "TaskDetailsScreen";

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  TaskStatus taskStatus = TaskStatus.newTask;
var titleController = TextEditingController();
 var descriptionController = TextEditingController();
var updateViewModel = UpdateTaskCubit();
  final formKey = GlobalKey<FormState>();

 @override
  void initState() {
   super.initState();
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     Arrgs arrgs = ModalRoute
         .of(context)!
         .settings
         .arguments as Arrgs;
     checkTaskStatus(arrgs);
     titleController.text = arrgs.getTasksData[arrgs.index].name ?? '';
     descriptionController.text =
         arrgs.getTasksData[arrgs.index].description ?? '';

   print(taskStatus.index);
   setState(() {

   });


   });
  }
  @override
  Widget build(BuildContext context) {
    Arrgs arrgs = ModalRoute.of(context)!.settings.arguments as Arrgs;

    AuthProvider userProvider = Provider.of<AuthProvider>(context,listen: false);


    return Scaffold(
      backgroundColor: Color(0xffF3FAF9),
      appBar: AppBar(
        actions: [

          CircularPercentIndicator(

            radius: 28.0,
            lineWidth: 8,
            percent:  .44,
            center:  Text('10/15',
              style: TextStyle(
                  color: Colors.black),),
            progressColor: Color(0xff94C68D),
            backgroundColor: Color(0xff94C68D).withOpacity(.5),
          ),
          SizedBox(width: 20,),
          CircularPercentIndicator(

            radius: 28.0,
            lineWidth: 8,
            percent:  .44,
            center:  Text('3/9',
              style: TextStyle(
                  color: Colors.black),),
            progressColor: Color(0xffFBA85B),

            backgroundColor: Color(0xffFBA85B).withOpacity(.5),
          ),
          SizedBox(width: 20,),

          CircularPercentIndicator(

            radius: 28.0,
            lineWidth: 8,
            percent:  .44,
            center:  Text('9/12',
              style: TextStyle(
                  color: Colors.black),),
            progressColor: Color(0xffF87B7B),
            backgroundColor: Color(0xffF87B7B).withOpacity(.5),
          ),
          SizedBox(width: 20,),

        ],
        backgroundColor: Color(0xffF3FAF9),

        centerTitle: false,
        title: Column(
          children: [
            Text('Today',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700
            ),),
            Text('1/3/2023'
              ,style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400
              ),)
          ],
        ),
      ),
      body: BlocConsumer<UpdateTaskCubit,UpdateTaskViewState>(
        bloc: updateViewModel,
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
            DialogUtilities.showMessage(
                context,
                state.message,
                posstiveActionName: "ok");
          }
          else if (state is UpdateTaskLoadingState) {
            //show loading...
            DialogUtilities.showLoadingDialog(
                context,
                "Loading...");
          }
          else if (state is UpdateTaskSuccessState) {
            if (state.updateTaskResponse.status == true) {

              DialogUtilities.showMessage(context, "Updated Successfully",
                  posstiveActionName: "ok", posstiveAction: () async {

                    Navigator.of(context)
                        .pushReplacementNamed(HomeSceen.routeName);
                  });
            } else if (state.updateTaskResponse.status == false) {
              DialogUtilities.showMessage(
                context,
                " ${state.updateTaskResponse.message}",
                posstiveActionName: 'Ok',
              );
            }
            // show dialog
            // navigate to home screen
          }
        },


        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    if(userProvider.userType == 'admin'|| userProvider.userType == 'manager')
                      CustomFormField(controller: titleController,
                        hintlText: 'Edit',
                        validator: (text) {
                          if(text!.isEmpty){
                            return 'Please Enter Task Title';
                          }
                          return null;
                        },

                      )

                    else
                      Text(titleController.text
                        ,style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800
                        ),),

                    SizedBox(height: 10,),
                    Container(
                      child: Center(child: Text('Image')),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Assigned by',style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey
                            ),),
                            Text(arrgs.getTasksData[arrgs.index].creator?.name??'',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,

                            ),),
                          ],

                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Due Date',style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey
                            ),),
                            Text(arrgs.getTasksData[arrgs.index].enddate??'',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,

                            ),),

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height:20,),


                    //
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       height: MediaQuery.of(context).size.height * 0.05,
                    //       width: MediaQuery.of(context).size.width * 0.30,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(6),
                    //           border: Border.all()),
                    //       child: Center(
                    //         child: Row(
                    //           children: [
                    //             Radio<TaskStatus>(
                    //               value: TaskStatus.newTask,
                    //               groupValue: taskStatus,
                    //               onChanged: (value) {
                    //                 setState(() {
                    //                   taskStatus = value!;
                    //                 });
                    //               },
                    //             ),
                    //             const Text(
                    //               'NEW',
                    //               style: TextStyle(fontSize: 10),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       height: MediaQuery.of(context).size.height * 0.05,
                    //       width: MediaQuery.of(context).size.width * 0.30,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(6),
                    //           border: Border.all()),
                    //       child: Row(
                    //         children: [
                    //           Radio<TaskStatus>(
                    //             value: TaskStatus.processing,
                    //             groupValue: taskStatus,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 taskStatus = value!;
                    //               });
                    //             },
                    //           ),
                    //           const Text(
                    //             'PROCCESSING',
                    //             style: TextStyle(fontSize: 10),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Container(
                    //       height: MediaQuery.of(context).size.height * 0.05,
                    //       width: MediaQuery.of(context).size.width * 0.30,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(6),
                    //           border: Border.all()),
                    //       child: Row(
                    //         children: [
                    //           Radio<TaskStatus>(
                    //             value: TaskStatus.canceled,
                    //             groupValue: taskStatus,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 taskStatus = value!;
                    //               });
                    //             },
                    //           ),
                    //           const Text(
                    //             'CANCELED',
                    //             style: TextStyle(fontSize: 10),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       height: MediaQuery.of(context).size.height * 0.05,
                    //       width: MediaQuery.of(context).size.width * 0.30,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(6),
                    //           border: Border.all()),
                    //       child: Center(
                    //         child: Row(
                    //           children: [
                    //             Radio<TaskStatus>(
                    //               value: TaskStatus.completed,
                    //               groupValue: taskStatus,
                    //               onChanged: (value) {
                    //                 setState(() {
                    //                   taskStatus = value!;
                    //                 });
                    //               },
                    //             ),
                    //             const Text(
                    //               'COMPLETED',
                    //               style: TextStyle(fontSize: 10),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       height: MediaQuery.of(context).size.height * 0.05,
                    //       width: MediaQuery.of(context).size.width * 0.30,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(6),
                    //           border: Border.all()),
                    //       child: Row(
                    //         children: [
                    //           Radio<TaskStatus>(
                    //             value: TaskStatus.notCompleted,
                    //             groupValue: taskStatus,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 taskStatus = value!;
                    //               });
                    //             },
                    //           ),
                    //           const Text(
                    //             'NOTCOMPLETED',
                    //             style: TextStyle(fontSize: 9),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Container(
                    //       height: MediaQuery.of(context).size.height * 0.05,
                    //       width: MediaQuery.of(context).size.width * 0.30,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(6),
                    //           border: Border.all()),
                    //       child: Row(
                    //         children: [
                    //           Radio<TaskStatus>(
                    //             value: TaskStatus.expired,
                    //             groupValue: taskStatus,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 taskStatus = value!;
                    //               });
                    //             },
                    //           ),
                    //           const Text(
                    //             'EXPIRED',
                    //             style: TextStyle(fontSize: 10),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),



                    SizedBox(
                      height: 160,
                      child: GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 8 / 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all()),
                            child: Row(
                              children: [
                                Radio<TaskStatus>(
                                  value: TaskStatus.newTask,
                                  groupValue: taskStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      taskStatus = value!;
                                    });
                                  },
                                ),
                                const Text('New'),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all()),
                            child: Row(
                              children: [
                                Radio<TaskStatus>(
                                  value: TaskStatus.processing,
                                  groupValue: taskStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      taskStatus = value!;
                                    });
                                  },
                                ),
                                const Text('Processing'),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all()),
                            child: Row(
                              children: [
                                Radio<TaskStatus>(
                                  value: TaskStatus.canceled,
                                  groupValue: taskStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      taskStatus = value!;
                                    });
                                  },
                                ),
                                const Text('Canceled'),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all()),
                            child: Row(
                              children: [
                                Radio<TaskStatus>(
                                  value: TaskStatus.completed,
                                  groupValue: taskStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      taskStatus = value!;
                                    });
                                  },
                                ),
                                const Text('Completed'),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all()),
                            child: Row(
                              children: [
                                Radio<TaskStatus>(
                                  value: TaskStatus.notCompleted,
                                  groupValue: taskStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      taskStatus = value!;
                                    });
                                  },
                                ),
                                const Text('Not Completed'),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all()),
                            child: Row(
                              children: [
                                Radio<TaskStatus>(
                                  value: TaskStatus.expired,
                                  groupValue: taskStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      taskStatus = value!;
                                    });
                                  },
                                ),
                                const Text('Expired'),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          )

                        ], ),
                    ),
                    SizedBox(height: 10,),
                    Text('Description',style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),
                    if(userProvider.userType == 'admin'|| userProvider.userType == 'manager')
                      CustomFormField(controller: descriptionController,
                        hintlText: 'Edit',

                        validator: (text) {
                          if(text!.isEmpty){
                            return 'Please Enter Description';
                          }
                          return null;
                        },

                      )

                    else
                      Text(arrgs.getTasksData[arrgs.index].description??''
                        ,style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800
                        ),),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() == false) {
                            return;
                          }
                          updateViewModel.updateTask(
                            status: '${taskStatus.index}',
                              name: titleController.text,
                              employeeId:' ${arrgs.getTasksData[arrgs.index].employee?.id}',
                              token: userProvider.token??'',
                              description: descriptionController.text,
                              startDay: '${arrgs.getTasksData[arrgs.index].startdate}',
                              endDate: '${arrgs.getTasksData[arrgs.index].enddate}',
                              taskId: arrgs.getTasksData[arrgs.index].id??-1);
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
              ),
            ),
          );
        },


      ),
    );
  }


  void checkTaskStatus(Arrgs arrgs){

    if(arrgs.getTasksData[arrgs.index].status == 'new'){
      taskStatus = TaskStatus.newTask;
    }else if(arrgs.getTasksData[arrgs.index].status == 'processing'){
      taskStatus = TaskStatus.processing;
    }else if(arrgs.getTasksData[arrgs.index].status == 'canceled'){
      taskStatus = TaskStatus.canceled;
    }else if(arrgs.getTasksData[arrgs.index].status == 'completed'){
      taskStatus = TaskStatus.completed;
    }else if(arrgs.getTasksData[arrgs.index].status == 'not completed'){
      taskStatus = TaskStatus.notCompleted;
    }else if(arrgs.getTasksData[arrgs.index].status == 'expired'){
      taskStatus = TaskStatus.expired;
    }
  }

}
