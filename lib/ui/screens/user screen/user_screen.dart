import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_management_erra_soft_training/ui/components/task_widget.dart';
import 'package:task_management_erra_soft_training/ui/screens/add%20new%20task/add_new_task.dart';
import 'package:task_management_erra_soft_training/ui/screens/home%20screen/home_screen.dart';
import 'package:task_management_erra_soft_training/ui/screens/task%20details/task_details.dart';
import 'package:task_management_erra_soft_training/ui/screens/user%20screen/delete%20task%20MVVM/delete_task_cubit.dart';

import '../../../api/models/get all task/Data.dart';
import '../../../api/models/get all task/GetTaskResponse.dart';
import '../../../providers/auth_provider.dart';
import '../../components/dialog.dart';
import '../edit task/edit_task.dart';
import 'delete task MVVM/delete_task_states.dart';
import 'get all tasks MVVM/get_all_tasks_cubit.dart';
import 'get all tasks MVVM/get_all_tasks_states.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});
  static const String routeName = 'user-screen';
  var getAllTasksViewModel = GetAllTasksCubit();
  var deleteTaskViewModel = DeleteTaskCubit();
  bool isVisible = true;
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider =
    Provider.of<AuthProvider>(context, listen: false);
    if(userProvider.userType == 'admin'||userProvider.userType == 'manager'){
      isVisible = true;
    }
    else{
      isVisible = false;
    }

    getAllTasksViewModel.getAllTasks(token: userProvider.token??'');

    return Scaffold(
        backgroundColor: Color(0xffF3FAF9),
        body: BlocBuilder<GetAllTasksCubit, GetAllTasksViewState>(
          bloc: getAllTasksViewModel,
          builder: (context, getAllTaskState) {
            if (getAllTaskState is GetAllTasksLoadingState) {
              return   SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Color(0xff5A55CA),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                        children: [
                          Expanded(
                              child: ListView.separated(
                                itemCount: 10,

                                separatorBuilder: (context, index) => SizedBox(
                                  height: 20,
                                ),
                                itemBuilder: (context, index) => InkWell(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25)),
                                    elevation: 7,
                                    color: Color(0xffFFFFFF),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Loading...',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                              Visibility(
                                                maintainState: true,
                                                maintainAnimation: true,
                                                maintainSize: true,
                                                visible: isVisible,
                                                child: IconButton(
                                                    onPressed: (){

                                                    },
                                                    icon: Icon(Icons.delete_outline)),
                                              )
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 5,
                                                height: 70,
                                                color: Color(0xff5A55CA),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Loading...",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    'Loading...',
                                                    maxLines: 1,
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.access_time),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text('Loading...')
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),




                                ),

                              )
                          ),

                          BlocListener<DeleteTaskCubit, DeleteTaskViewState>(
                            bloc: deleteTaskViewModel,
                            listenWhen: (previous, current) {
                              if (previous is DeleteTaskLoadingState) {
                                DialogUtilities.hideDialog(context);
                              }
                              if (current is DeleteTaskSuccessState ||
                                  current is DeleteTaskLoadingState ||
                                  current is DeleteTaskFailState) {
                                return true;
                              }
                              return false;
                            },

                            listener: (context, deleteState) {
                              // event
                              if (deleteState is DeleteTaskFailState) {
                                // show message
                                DialogUtilities.showMessage(
                                    context,
                                    deleteState.message,
                                    posstiveActionName: "ok");
                              }
                              else if (deleteState is DeleteTaskLoadingState) {
                                //show loading...
                                DialogUtilities.showLoadingDialog(
                                    context,
                                    "Loading...");
                              }
                              else if (deleteState is DeleteTaskSuccessState) {
                                if (deleteState.deleteTaskResponse.status == true) {
                                  DialogUtilities.showMessage(context,
                                      deleteState.deleteTaskResponse.message??"",
                                      posstiveActionName: "ok",
                                      posstiveAction: () async {
                                        getAllTasksViewModel.getAllTasks(token: userProvider.token??'');
                                        //Navigator.pushNamed(context, UserScreen.routeName);
                                      });
                                }
                                else if(deleteState.deleteTaskResponse.status == false) {

                                  DialogUtilities.showMessage(
                                    context,
                                    deleteState.deleteTaskResponse.message??'',
                                    posstiveActionName: 'Ok',
                                  );
                                }
                                // DialogUtilities.hideDialog(context);
                              }
                              // DialogUtilities.hideDialog(context);
                            },
                            child: Container(),

                          ),

                        ]
                    ),


                  ),
                ),
              );
            } else if (getAllTaskState is GetAllTasksFailState) {
              return Text(getAllTaskState.message);
            } else if (getAllTaskState is GetAllTasksSuccessState) {
              if(getAllTaskState.getAllTasksResponse.data!.isEmpty){
                return Center(child: Text('There are no tasks'));
              }else{
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                      children: [
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // CalendarTimeline(
                        //   showYears: true,
                        //   initialDate: DateTime.now(),
                        //   firstDate: DateTime(2019, 1, 15),
                        //   lastDate: DateTime(2030, 11, 20),
                        //   onDateSelected: (date) => print(date),
                        //   leftMargin: 20,
                        //   monthColor: Colors.black,
                        //   dayColor: Colors.black,
                        //   activeDayColor: Colors.white,
                        //   activeBackgroundDayColor: Color(0xff5A55CA),
                        //   dotsColor: Color(0xFF333A47),
                        //   locale: 'en_ISO',
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Expanded(
                            child: ListView.separated(
                              itemCount: getAllTaskState.getAllTasksResponse.data?.length??0,

                              separatorBuilder: (context, index) => SizedBox(
                                height: 20,
                              ),
                              itemBuilder: (context, index)
                              {
                                getAllTaskState.getAllTasksResponse.data![index].status == 'new'?
                                color = Color(0xFF5A55CA) :
                                getAllTaskState.getAllTasksResponse.data![index].status == 'processing' ?
                                color = Color(0xFFFBA85B) :
                                getAllTaskState.getAllTasksResponse.data![index].status == 'not completed' ?
                                color = Color(0xFF64A0BA) :
                                getAllTaskState.getAllTasksResponse.data![index].status == 'expired' ?
                                color = Color(0xFFF87B7B) :
                                getAllTaskState.getAllTasksResponse.data![index].status == 'completed' ?
                                color = Color(0xFF94C68D): color =Colors.red;



                                return

                                InkWell(


                                onTap: () {
                                  Navigator.pushNamed(
                                      context, TaskDetailsScreen.routeName,
                                      arguments: Arrgs(
                                        id : getAllTaskState.getAllTasksResponse.data?[index].id??-1,
                                          index: index,
                                          getTasksData: getAllTaskState
                                              .getAllTasksResponse.data ?? []
                                      ));
                                },
                                child: TaskiWidget(
                                // editOnTap: (){
                                //     Navigator.pushNamed(context, EditTask.routeName,
                                //         arguments: Arrgs(
                                //         index: index,
                                //         getTasksData: getAllTaskState
                                //             .getAllTasksResponse.data ?? []
                                //     ));
                                //     // showDialog(
                                //     //   barrierDismissible: true,
                                //     //     context: context,
                                //     //     builder: (context) {
                                //     //       return Dialog(
                                //     //         child: Container(
                                //     //           width: double.infinity,
                                //     //           child: Padding(
                                //     //             padding: const EdgeInsets.all(8.0),
                                //     //             child: Column(
                                //     //               children: [
                                //     //                 TextFormField(),
                                //     //                 SizedBox(height: 10,),
                                //     //
                                //     //
                                //     //               ],
                                //     //             ),
                                //     //           ),
                                //     //         )
                                //     //
                                //     //       );
                                //     //     },
                                //     // );
                                //   },
                                  color:color,
                                  onTap: () {
                                    DialogUtilities.showMessage(
                                        context,
                                        'Are you sure you want to Delete this task',
                                        nigaiveActionName: 'Delete',
                                        nigaiveAction: () {
                                          deleteTask(taskId: getAllTaskState
                                              .getAllTasksResponse.data?[index]
                                              .id ?? -1,
                                              token: userProvider.token ?? '');
                                        },
                                        posstiveActionName: 'No'
                                    );
                                  },
                                  name: getAllTaskState.getAllTasksResponse
                                      .data?[index].name ?? "",
                                  status: getAllTaskState.getAllTasksResponse
                                      .data?[index].status ?? '',
                                  description: getAllTaskState
                                      .getAllTasksResponse.data?[index]
                                      .description ?? '',
                                  startTime: getAllTaskState.getAllTasksResponse
                                      .data?[index].startdate ?? "",
                                  endTime: getAllTaskState.getAllTasksResponse
                                      .data?[index].enddate ?? "",
                                  isVisible: isVisible,
                                ),


                              );
                              }

                            )
                        ),

                        BlocListener<DeleteTaskCubit, DeleteTaskViewState>(
                          bloc: deleteTaskViewModel,
                          listenWhen: (previous, current) {
                            if (previous is DeleteTaskLoadingState) {
                              DialogUtilities.hideDialog(context);
                            }
                            if (current is DeleteTaskSuccessState ||
                                current is DeleteTaskLoadingState ||
                                current is DeleteTaskFailState) {
                              return true;
                            }
                            return false;
                          },

                          listener: (context, deleteState) {
                            // event
                            if (deleteState is DeleteTaskFailState) {
                              // show message
                              DialogUtilities.showMessage(
                                  context,
                                  deleteState.message,
                                  posstiveActionName: "ok");
                            }
                            else if (deleteState is DeleteTaskLoadingState) {
                              //show loading...
                              DialogUtilities.showLoadingDialog(
                                  context,
                                  "Loading...");
                            }
                            else if (deleteState is DeleteTaskSuccessState) {
                              if (deleteState.deleteTaskResponse.status == true) {
                                DialogUtilities.showMessage(context,
                                    deleteState.deleteTaskResponse.message??"",
                                    posstiveActionName: "ok",
                                    posstiveAction: () async {
                                      getAllTasksViewModel.getAllTasks(token: userProvider.token??'');
                                      //Navigator.pushNamed(context, UserScreen.routeName);
                                    });
                              }
                              else if(deleteState.deleteTaskResponse.status == false) {

                                DialogUtilities.showMessage(
                                  context,
                                  deleteState.deleteTaskResponse.message??'',
                                  posstiveActionName: 'Ok',
                                );
                              }
                              // DialogUtilities.hideDialog(context);
                            }
                            // DialogUtilities.hideDialog(context);
                          },
                          child: Container(),

                        ),
                        // BlocConsumer<DeleteTaskCubit, DeleteTaskViewState>(
                        //     bloc: deleteTaskViewModel,
                        //     listenWhen: (previous, current) {
                        //       if (previous is DeleteTaskLoadingState) {
                        //         DialogUtilities.hideDialog(context);
                        //       }
                        //       if (current is DeleteTaskSuccessState ||
                        //           current is DeleteTaskLoadingState ||
                        //           current is DeleteTaskFailState) {
                        //         return true;
                        //       }
                        //       return false;
                        //     },
                        //     buildWhen: (previous, current) {
                        //       if (current is DeleteTaskInitialState) return true;
                        //       return false;
                        //     },
                        //     listener: (context, deleteState) {
                        //       // event
                        //       if (deleteState is DeleteTaskFailState) {
                        //         // show message
                        //         DialogUtilities.showMessage(
                        //             context,
                        //             deleteState.message,
                        //             posstiveActionName: "ok");
                        //       }
                        //       else if (deleteState is DeleteTaskLoadingState) {
                        //         //show loading...
                        //         DialogUtilities.showLoadingDialog(
                        //             context,
                        //             "Loading...");
                        //       }
                        //       else if (deleteState is DeleteTaskSuccessState) {
                        //         if (deleteState.deleteTaskResponse.status == true) {
                        //           DialogUtilities.showMessage(context,
                        //               deleteState.deleteTaskResponse.message??"",
                        //               posstiveActionName: "ok",
                        //               posstiveAction: () async {
                        //                 getAllTasksViewModel.getAllTasks(token: userProvider.token??'');
                        //                 //Navigator.pushNamed(context, UserScreen.routeName);
                        //               });
                        //         }
                        //         else if(deleteState.deleteTaskResponse.status == false) {
                        //
                        //           DialogUtilities.showMessage(
                        //             context,
                        //             deleteState.deleteTaskResponse.message??'',
                        //             posstiveActionName: 'Ok',
                        //           );
                        //         }
                        //         // DialogUtilities.hideDialog(context);
                        //       }
                        //       // DialogUtilities.hideDialog(context);
                        //     },
                        //     builder: (context, state) {
                        //       return Container();
                        //     }
                        //
                        // ),

                      ]
                  ),


                );
              }

            } else {
              return Container();
            }
          },
        ));
  }
void deleteTask({required String token,required int taskId}) {
    deleteTaskViewModel.deleteTask(taskId: taskId, token: token);
}

}

class Arrgs{
  int? id;
  int index;
  List<GetTaskData> getTasksData;
  Arrgs({required this.index,required this.getTasksData, this.id});
}
