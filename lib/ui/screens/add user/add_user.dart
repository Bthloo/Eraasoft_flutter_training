import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_management_erra_soft_training/ui/screens/add%20user/MVVM/create_user_cubit.dart';

import '../../../api/models/create user/CreateUserResponse.dart';
import '../../../providers/auth_provider.dart';
import '../../components/custom_form_field.dart';
import '../../components/dialog.dart';
import '../home screen/home_screen.dart';
import 'MVVM/create_user_states.dart';

class AddUser extends StatefulWidget {
   AddUser({super.key});
  static const String routeName = 'adddUserScreen';

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final formkey = GlobalKey<FormState>();

   final emailController = TextEditingController();

   final passwordController = TextEditingController();

   final nameController = TextEditingController();

   final phoneController = TextEditingController();

   var viewModel = CreateUserCubit();

  UserTypes userType = UserTypes.admin;

  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider = Provider.of<AuthProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<CreateUserCubit, CreateUserViewState>(
        bloc: viewModel,
        listenWhen: (previous, current) {
          if (previous is CreateUserLoadingState) {
            DialogUtilities.hideDialog(context);
          }
          if (current is CreateUserSuccessState ||
              current is CreateUserLoadingState ||
              current is CreateUserFailState) {
            return true;
          }
          return false;
        },
        buildWhen: (previous, current) {
          if (current is CreateUserInitialState) return true;
          return false;
        },
        listener: (context, state) {
          // event
          if (state is CreateUserFailState) {
            // show message
            DialogUtilities.showMessage(
                context,
                state.message,
                posstiveActionName: "ok");
          } else if (state is CreateUserLoadingState) {
            //show loading...
            DialogUtilities.showLoadingDialog(
                context,
                "Loading...");
          } else if (state is CreateUserSuccessState) {
            if (state.createUserResponse.status == true) {
              DialogUtilities.showMessage(context,
                  'Added Successfully',
                  posstiveActionName: "ok",
                  posstiveAction: () async {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeSceen.routeName);
                  });
            }
            else if(state.createUserResponse.status == false) {
              DialogUtilities.showMessage(
                context,
                state.createUserResponse.data!.name![0],
                posstiveActionName: 'Ok',
              );
            }
          }
        },
        builder: (context,state) {
          return
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Add New User!',style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold
                      ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('''Create a new user now and assign
           them tasks right away.''',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff7C808A)
                        ),
                        ),
                      ),

                      SizedBox(height: 20,),
                      CustomFormField(
                        hintlText:"Name",
                        controller: nameController,
                        isPassword: false,
                        validator: (text) {
                          if (text!.length <  3 || text.trim().isEmpty|| text.length > 20) {
                            return 'The Name Should be more than 3 char and less than 20 char';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20,),
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
                        hintlText:"Phone",
                        controller: phoneController,
                        isPassword: false,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please Enter a Phone Number';
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
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all()),
                            child: Row(
                              children: [
                                Radio<UserTypes>(
                                  value: UserTypes.admin,
                                  groupValue: userType,
                                  onChanged: (value) {
                                    setState(() {
                                      userType = value!;
                                    });
                                  },
                                ),
                                const Text('Admin'),
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
                                Radio<UserTypes>(
                                  value: UserTypes.manager,
                                  groupValue: userType,
                                  onChanged: (value) {
                                    setState(() {
                                      userType = value!;
                                    });
                                  },
                                ),
                                const Text('Manager'),
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
                                Radio<UserTypes>(
                                  value: UserTypes.user,
                                  groupValue: userType,
                                  onChanged: (value) {
                                    setState(() {
                                      userType = value!;
                                    });
                                  },
                                ),
                                const Text('User'),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){
                            adduser(userProvider.token??'');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 17.0),
                            child: Text('Create',
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
              ),
            );
        },
      ));







  }

   void adduser(String token) async {
     if (formkey.currentState?.validate() == false) {
       return;
     }
     viewModel.createUser(email: emailController.text,
         password: passwordController.text,
         name: nameController.text,
         phone:'0949494949',
         token: token,
       userType: '1'

     );


   }
}
