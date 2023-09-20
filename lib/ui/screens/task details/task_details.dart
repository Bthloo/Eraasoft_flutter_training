
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:task_management_erra_soft_training/ui/screens/task%20details/task_status.dart';
import 'package:task_management_erra_soft_training/ui/screens/user%20screen/user_screen.dart';

import '../../../api/models/create user/CreateUserResponse.dart';
import '../../../providers/auth_provider.dart';
import '../user screen/get all tasks MVVM/get_all_tasks_states.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});
static const String routeName = "TaskDetailsScreen";

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
 late TaskStatus taskStatus = TaskStatus.newTask;
 bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    Arrgs arrgs = ModalRoute.of(context)!.settings.arguments as Arrgs;
    checkTaskStatus(arrgs);
    AuthProvider userProvider = Provider.of<AuthProvider>(context,listen: false);
    if(userProvider.userType == 'admin'){
      isVisible = true;
    }else{
      isVisible = false;
    }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(arrgs.getTasksData[arrgs.index].name??''
                ,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800
              ),),
              Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: isVisible,
                child: TextButton(
                    onPressed: (){},
                    child: Text('Tap to Edit',style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      color: Colors.grey
                    ),),),
              ),
              SizedBox(height: 10,),
              Container(
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
              Row(
                children: [
                  Text('Description',style: TextStyle(
                  fontSize: 20,
                    fontWeight: FontWeight.w500
              ),),
                  TextButton(
                      onPressed: (){},
                      child:  Text('Tap to Edit',style: TextStyle(
                        color: Colors.grey
                      ),))
                ],
              ),
              Text(arrgs.getTasksData[arrgs.index].description??'',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18
              ),
              )


            ],
          ),
        ),
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
