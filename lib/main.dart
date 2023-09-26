import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_erra_soft_training/providers/auth_provider.dart';
import 'package:task_management_erra_soft_training/ui/screens/add%20department/add_department.dart';
import 'package:task_management_erra_soft_training/ui/screens/add%20new%20task/add_new_task.dart';
import 'package:task_management_erra_soft_training/ui/screens/add%20user/add_user.dart';
import 'package:task_management_erra_soft_training/ui/screens/edit%20task/edit_task.dart';
import 'package:task_management_erra_soft_training/ui/screens/home%20screen/home_screen.dart';
import 'package:task_management_erra_soft_training/ui/screens/logout%20screen/homeScreen.dart';
import 'package:task_management_erra_soft_training/ui/screens/login/login_screen.dart';
import 'package:task_management_erra_soft_training/ui/screens/task%20details/task_details.dart';
import 'package:task_management_erra_soft_training/ui/screens/update%20department/update_department.dart';
import 'package:task_management_erra_soft_training/ui/screens/update%20user/update_user.dart';
import 'package:task_management_erra_soft_training/ui/screens/user%20screen/user_screen.dart';

void main() {
  runApp( ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff5A55CA)),
        useMaterial3: true,
      ),
       initialRoute: LogInScreen.routeName,
      routes: {
        LogInScreen.routeName : (_) => LogInScreen(),
        LogoutScreen.routeName : (_) => LogoutScreen(),
        HomeSceen.routeName : (_) => HomeSceen(),
        AddUser.routeName : (_) => AddUser(),
        AddDepartment.routeName : (_) => AddDepartment(),
        UpdateDepartment.routeName : (_) => UpdateDepartment(),
        UpdateUser.routeName : (_) => UpdateUser(),
        UserScreen.routeName : (_) => UserScreen(),
        AddNewTask.routeName : (_) => AddNewTask(),
        TaskDetailsScreen.routeName : (_) => TaskDetailsScreen(),
        EditTask.routeName : (_) => EditTask()
      },
    );
  }
}
