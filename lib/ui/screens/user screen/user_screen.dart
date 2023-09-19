import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:task_management_erra_soft_training/ui/screens/home%20screen/home_screen.dart';
import 'package:task_management_erra_soft_training/ui/screens/task%20details/task_details.dart';
import 'package:task_management_erra_soft_training/ui/screens/user%20screen/delete%20task%20MVVM/delete_task_cubit.dart';

import '../../../api/models/get all task/Data.dart';
import '../../../api/models/get all task/GetTaskResponse.dart';
import '../../../providers/auth_provider.dart';
import '../../components/dialog.dart';
import 'delete task MVVM/delete_task_states.dart';
import 'get all tasks MVVM/get_all_tasks_cubit.dart';
import 'get all tasks MVVM/get_all_tasks_states.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});
  static const String routeName = 'user-screen';
  var getAllTasksViewModel = GetAllTasksCubit();
  var deleteTaskViewModel = DeleteTaskCubit();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider =
    Provider.of<AuthProvider>(context, listen: false);
    if(userProvider.userType == 'admin'||userProvider.userType == 'manager'){
      isVisible = true;
    }else{
      isVisible = false;
    }
    getAllTasksViewModel.getAllTasks(token: userProvider.token??'');

    return Scaffold(
        backgroundColor: Color(0xffF3FAF9),
        appBar: AppBar(

          actions: [
            CircularPercentIndicator(
              radius: 28.0,
              lineWidth: 8,
              percent: .44,
              center: Text(
                '10/15',
                style: TextStyle(color: Colors.black),
              ),
              progressColor: Color(0xff94C68D),
              backgroundColor: Color(0xff94C68D).withOpacity(.5),
            ),
            SizedBox(
              width: 20,
            ),
            CircularPercentIndicator(
              radius: 28.0,
              lineWidth: 8,
              percent: .44,
              center: Text(
                '3/9',
                style: TextStyle(color: Colors.black),
              ),
              progressColor: Color(0xffFBA85B),
              backgroundColor: Color(0xffFBA85B).withOpacity(.5),
            ),
            SizedBox(
              width: 20,
            ),
            CircularPercentIndicator(
              radius: 28.0,
              lineWidth: 8,
              percent: .44,
              center: Text(
                '9/12',
                style: TextStyle(color: Colors.black),
              ),
              progressColor: Color(0xffF87B7B),
              backgroundColor: Color(0xffF87B7B).withOpacity(.5),
            ),
            SizedBox(
              width: 20,
            ),
          ],
          backgroundColor: Color(0xffF3FAF9),
          centerTitle: false,
          title: Column(
            children: [
              Text(
                'Today',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Text(
                '1/3/2023',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        body: BlocBuilder<GetAllTasksCubit, GetAllTasksViewState>(
          bloc: getAllTasksViewModel,
          builder: (context, getAllTaskState) {
            if (getAllTaskState is GetAllTasksLoadingState) {
              return CircularProgressIndicator();
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
                        SizedBox(
                          height: 10,
                        ),
                        CalendarTimeline(
                          showYears: true,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2019, 1, 15),
                          lastDate: DateTime(2030, 11, 20),
                          onDateSelected: (date) => print(date),
                          leftMargin: 20,
                          monthColor: Colors.black,
                          dayColor: Colors.black,
                          activeDayColor: Colors.white,
                          activeBackgroundDayColor: Color(0xff5A55CA),
                          dotsColor: Color(0xFF333A47),
                          locale: 'en_ISO',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: ListView.separated(
                              itemCount: getAllTaskState.getAllTasksResponse.data?.length??0,

                              separatorBuilder: (context, index) => SizedBox(
                                height: 20,
                              ),
                              itemBuilder: (context, index) => InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, TaskDetailsScreen.routeName,
                                      arguments: Arrgs(
                                          index: index,
                                          getTasksData: getAllTaskState.getAllTasksResponse.data??[]
                                      ));
                                },
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
                                              getAllTaskState.getAllTasksResponse.data?[index].status??'',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            Visibility(
                                              maintainState: true,
                                              maintainAnimation: true,
                                              maintainSize: true,
                                              visible: isVisible,
                                              child: IconButton(
                                                  onPressed: (){
                                                    DialogUtilities.showMessage(
                                                        context,
                                                        'Are you sure you want to Delete this task',
                                                        nigaiveActionName: 'Delete',
                                                        nigaiveAction: (){
                                                          deleteTask(taskId: getAllTaskState.getAllTasksResponse.data?[index].id??-1 ,token: userProvider.token??'');
                                                        },
                                                        posstiveActionName: 'Yes'
                                                    );
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
                                                  getAllTaskState.getAllTasksResponse.data?[index].name??"",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  getAllTaskState.getAllTasksResponse.data?[index].description??'',
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
                                            Text('start ${getAllTaskState.getAllTasksResponse.data?[index].startdate} - ends ${getAllTaskState.getAllTasksResponse.data?[index].enddate}')
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),



                                // Card(
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(25)),
                                //   elevation: 7,
                                //   color: Color(0xffFFFFFF),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(15.0),
                                //     child: Column(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Text(
                                //               getAllTaskState.getAllTasksResponse.data?[index].status??'',
                                //               style: TextStyle(fontSize: 25),
                                //             ),
                                //             Visibility(
                                //               maintainState: true,
                                //               maintainAnimation: true,
                                //               maintainSize: true,
                                //               visible: true,
                                //               child: IconButton(
                                //                   onPressed: (){
                                //                     // DialogUtilities.showMessage(
                                //                     //     context,
                                //                     //     'Are you sure you want to Delete this task',
                                //                     //   nigaiveAction: (){
                                //                     //
                                //                     //
                                //                     //     deleteTask(taskId: getAllTaskState.getAllTasksResponse.data?[index].id??-1 ,token: userProvider.token??'');
                                //                     //     if(){}
                                //                     //
                                //                     //   },
                                //                     //   posstiveActionName: 'No',
                                //                     //   nigaiveActionName: 'Delete'
                                //                     // );
                                //                   },
                                //                   icon: Icon(Icons.delete_outline)),
                                //             )
                                //           ],
                                //         ),
                                //         Divider(),
                                //         Row(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           children: [
                                //             Container(
                                //               width: 5,
                                //               height: 70,
                                //               color: Color(0xff5A55CA),
                                //             ),
                                //             SizedBox(
                                //               width: 5,
                                //             ),
                                //             Column(
                                //               crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //               children: [
                                //                 Text(
                                //                   getAllTaskState.getAllTasksResponse.data?[index].name??"",
                                //                   maxLines: 1,
                                //                   style: TextStyle(
                                //                       fontWeight: FontWeight.w700,
                                //                       fontSize: 20),
                                //                 ),
                                //                 SizedBox(
                                //                   height: 20,
                                //                 ),
                                //                 Text(
                                //                   getAllTaskState.getAllTasksResponse.data?[index].description??'',
                                //                   maxLines: 1,
                                //                   style: TextStyle(fontSize: 15),
                                //                 ),
                                //               ],
                                //             ),
                                //           ],
                                //         ),
                                //         SizedBox(
                                //           height: 20,
                                //         ),
                                //         Row(
                                //           children: [
                                //             Icon(Icons.access_time),
                                //             SizedBox(
                                //               width: 5,
                                //             ),
                                //             Text('start ${getAllTaskState.getAllTasksResponse.data?[index].startdate} - ends ${getAllTaskState.getAllTasksResponse.data?[index].enddate}')
                                //           ],
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // ),


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
              print('succsess');
              print(getAllTaskState.getAllTasksResponse.data?[1].name);

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
  int index;
  List<GetTaskData> getTasksData;
  Arrgs({required this.index,required this.getTasksData});
}
