import 'package:flutter/material.dart';
import 'package:task_management_erra_soft_training/ui/screens/add%20new%20task/add_new_task.dart';
import 'package:task_management_erra_soft_training/ui/screens/add%20user/add_user.dart';
import 'package:task_management_erra_soft_training/ui/screens/task%20details/task_details.dart';
import 'package:task_management_erra_soft_training/ui/screens/update%20user/update_user.dart';

import '../screens/add department/add_department.dart';
import '../screens/update department/update_department.dart';
import '../screens/user screen/user_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              SizedBox(height: 90,),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, AddUser.routeName);
              },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Add New User',style: TextStyle(
                    fontSize: 20
                  ),),
                )),
            const Divider(),
            InkWell(
                onTap: (){
                  Navigator.pushNamed(context, AddDepartment.routeName);

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Add Department',style: TextStyle(
                      fontSize: 20
                  ),),
                )),
            const Divider(),
            InkWell(
                onTap: (){
                  Navigator.pushNamed(context, UpdateDepartment.routeName);

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Update Department',style: TextStyle(
                      fontSize: 20
                  ),),
                )),

            const Divider(),

            InkWell(
                onTap: (){
                  Navigator.pushNamed(context, AddNewTask.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Add New Task',style: TextStyle(
                      fontSize: 20
                  ),),
                )),
            const Divider(),


          ],
        ),
      ),
    );
  }
}
