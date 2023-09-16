import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_erra_soft_training/providers/auth_provider.dart';
import 'package:task_management_erra_soft_training/ui/screens/home%20screen/homeScreen.dart';
import 'package:task_management_erra_soft_training/ui/screens/login/login_screen.dart';

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
        HomeScreen.routeName : (_) => HomeScreen()
      },
    );
  }
}
