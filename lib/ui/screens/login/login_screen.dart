import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_management_erra_soft_training/ui/screens/home%20screen/home_screen.dart';

import '../../../providers/auth_provider.dart';
import '../../components/custom_form_field.dart';
import '../../components/dialog.dart';
import '../logout screen/homeScreen.dart';
import 'MVVM/login_states.dart';
import 'MVVM/login_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogInScreen extends StatelessWidget {
   LogInScreen({super.key});
static const String routeName = 'loginScreen';
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'mostafa@admin.com');
  final passwordController = TextEditingController(text:'password');
  var viewModel = LoginCubit();
  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider = Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(),
      body:  BlocConsumer<LoginCubit, LoginViewState>(
        bloc: viewModel,
        listenWhen: (previous, current) {
          if (previous is LoginLoadingState) {
            DialogUtilities.hideDialog(context);
          }
          if (current is LoginSuccessState ||
              current is LoginLoadingState ||
              current is LoginFailState) {
            return true;
          }
          return false;
        },
        buildWhen: (previous, current) {
          if (current is LoginInitialState) return true;
          return false;
        },
        listener: (context, state) {
          // event
          if (state is LoginFailState) {
            // show message
            DialogUtilities.showMessage(
                context,
                state.message,
                posstiveActionName: "ok");
          } else if (state is LoginLoadingState) {
            //show loading...
            DialogUtilities.showLoadingDialog(
                context,
                "Loading...");
          } else if (state is LoginSuccessState) {
            if (state.logInResponse.status == true) {

              DialogUtilities.showMessage(context, "Logedin Successfully",
                  posstiveActionName: "ok", posstiveAction: () async {
                    final storage = FlutterSecureStorage();
                    await storage.write(key: 'token', value: state.logInResponse.data?.token);
                    userProvider.getToken();
                  //  writeSecureStorage(state.logInResponse.data?.token);
                    Navigator.of(context)
                        .pushReplacementNamed(HomeSceen.routeName);
                  });
            } else if (state.logInResponse.status == false) {
              DialogUtilities.showMessage(
                context,
                " ${state.logInResponse.message}",
                posstiveActionName: state.logInResponse.message,
              );
            }
            // show dialog
            // navigate to home screen
          }
        },
        builder: (context, state){
          return  Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Welcome Back!',style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('''Login to access your assigned tasks
              and personal overview.''',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff7C808A)
                    ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  CustomFormField(
                    hintlText:"Email",
                    controller: emailController,
                    isPassword: false,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please Enter Email Address';
                      }
                      var regex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
                      if(!regex.hasMatch(text)){
                        return 'please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  CustomFormField(
                    hintlText:"Password",
                    controller: passwordController,
                    isPassword: true,
                    validator: (text) {
                      if (text == null ||
                          text.trim().isEmpty ||
                          text.length < 6) {
                        return 'The Password Must at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  CheckboxListTile(
                    value: false,
                    onChanged: (bool? value){},
                    title: Text('Keep me logged in'),
                  ), //Checkbox
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        login(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                          ),),
                      ),
                      style: ButtonStyle(

                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).primaryColor
                          ),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
                          )
                      ),
                    ),
                  )

                ],
              ),
            ),
          );
        },
      ),
    );
  }

   void login(BuildContext context) async {
     if (formkey.currentState?.validate() == false) {
       return;
     }
     viewModel.login(
         email: emailController.text, password: passwordController.text);
     
   }

   Future<void> writeSecureStorage(String? token) async {
      final storage = FlutterSecureStorage();
       await storage.write(key: 'token', value: token);
   }

}
