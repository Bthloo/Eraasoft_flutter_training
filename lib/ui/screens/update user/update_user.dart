import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_management_erra_soft_training/ui/screens/update%20user/update%20users%20MMVM/update_user_cubit.dart';
import 'package:task_management_erra_soft_training/ui/screens/update%20user/update%20users%20MMVM/update_users_states.dart';

import '../../../providers/auth_provider.dart';
import '../../components/custom_form_field.dart';
import '../../components/department_drop_down_menue.dart';
import '../../components/drop_menue.dart';
import '../update department/get all department MVVM/get_all_department_cubit.dart';
import '../update department/get all department MVVM/get_all_department_states.dart';
import 'get all user MVVM/get_all_users_states.dart';
import 'get all user MVVM/get_users_cubit.dart';



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_management_erra_soft_training/ui/screens/add%20user/MVVM/create_user_cubit.dart';

import '../../../api/models/create user/CreateUserResponse.dart';
import '../../../providers/auth_provider.dart';
import '../../components/custom_form_field.dart';
import '../../components/dialog.dart';
import '../home screen/home_screen.dart';

class UpdateUser extends StatefulWidget {
  UpdateUser({super.key});
  static const String routeName = 'updateUserScreen';

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  final phoneController = TextEditingController();
  var getAllUserViewModel = GetAllUsersCubit();
  var updateUserViewModel = UpdateUsersCubit();
  var getAllDepartmentViewModel = GetAllDepartmentCubit();
  SingleValueDropDownController usersController = SingleValueDropDownController();
  SingleValueDropDownController departmentController = SingleValueDropDownController();
  UserTypes userType = UserTypes.admin;

  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider = Provider.of<AuthProvider>(context,listen: false);
    getAllUserViewModel.getAllUsers(token: userProvider.token??'');
    getAllDepartmentViewModel.getAllDepartment(token: userProvider.token??'');
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<UpdateUsersCubit, UpdateUsersViewState>(
          bloc: updateUserViewModel,
          listenWhen: (previous, current) {
            if (previous is UpdateUsersLoadingState) {
              DialogUtilities.hideDialog(context);
            }
            if (current is UpdateUsersSuccessState ||
                current is UpdateUsersLoadingState ||
                current is UpdateUsersFailState) {
              return true;
            }
            return false;
          },
          buildWhen: (previous, current) {
            if (current is UpdateUsersInitialState) return true;
            return false;
          },
          listener: (context, state) {
            // event
            if (state is UpdateUsersFailState) {
              // show message
              DialogUtilities.showMessage(
                  context,
                  state.message,
                  posstiveActionName: "ok");
            } else if (state is UpdateUsersLoadingState) {
              //show loading...
              DialogUtilities.showLoadingDialog(
                  context,
                  "Loading...");
            } else if (state is UpdateUsersSuccessState) {
              if (state.updateUsersResponse.status == true) {
                DialogUtilities.showMessage(context,
                    state.updateUsersResponse.message??'',
                    posstiveActionName: "ok",
                    posstiveAction: () async {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeSceen.routeName);
                    });
              }
              else if(state.updateUsersResponse.status == false) {

                DialogUtilities.showMessage(
                  context,
                  state.updateUsersResponse.updateUserdata!.name![0],
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
                        Text('Update User!',style: TextStyle(
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
                        BlocBuilder<GetAllUsersCubit, GetAllUsersViewState>(

                          bloc: getAllUserViewModel,
                          builder: (context, state) {
                            if (state is GetAllUsersLoadingState) {
                              return CircularProgressIndicator();
                            } else if (state is GetAllUsersFailState) {
                              return Text(state.message);
                            } else if (state is GetAllUsersSuccessState) {
                              return DefaultDropDown(
                                controller: usersController,
                                list: state.getAllUsersResponse.data ?? [],
                                label: 'Select User',
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        SizedBox(height: 20,),

                        BlocBuilder<GetAllDepartmentCubit, GetAllDepartmentViewState>(

                          bloc: getAllDepartmentViewModel,
                          builder: (context, state) {
                            if (state is GetAllDepartmentLoadingState) {
                              return CircularProgressIndicator();
                            } else if (state is GetAllDepartmentFailState) {
                              return Text(state.message);
                            } else if (state is GetAllDepartmentSuccessState) {
                              return DepartmentDropDown(
                                controller: departmentController,
                                list: state.getAllDepartmentResponse.data ?? [],
                                label: 'Assign Department',
                              );
                            } else {
                              return Container();
                            }
                          },
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
                              updateUser(userProvider.token??'');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 17.0),
                              child: Text('UPDATE',
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

  void updateUser(String token) async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    updateUserViewModel.updateUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phone:phoneController.text,
        token: token,
        userType: "${userType.index}",
        userId: usersController.dropDownValue?.value,
        departmentId: "${departmentController.dropDownValue?.value}"
    );


  }
}

















// class UpdateUser extends StatelessWidget {
//    UpdateUser({super.key});
//   static const String routeName = 'updateUserScreen';
//   final formkey = GlobalKey<FormState>();
//   var getAllUsersViewModel = GetAllUsersCubit();
//    final emailController = TextEditingController();
//    SingleValueDropDownController usersController =
//    SingleValueDropDownController();
//    final passwordController = TextEditingController();
//    final nameController = TextEditingController();
//    final phoneController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     AuthProvider userProvider =
//     Provider.of<AuthProvider>(context, listen: false);
//     getAllUsersViewModel.getAllUsers(token: userProvider.token??'');
//
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Form(
//           key: formkey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text('Update User!',style: TextStyle(
//                     fontSize: 34,
//                     fontWeight: FontWeight.bold
//                 ),
//                 ),
//                 SizedBox(height: 20,),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Text('''Create a new user now and assign
//            them tasks right away.''',style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff7C808A)
//                   ),
//                   ),
//                 ),
//
//                 SizedBox(height: 20,),
//                 BlocBuilder<GetAllUsersCubit, GetAllUsersViewState>(
//
//                   bloc: getAllUsersViewModel,
//                   builder: (context, state) {
//                     if (state is GetAllUsersLoadingState) {
//                       return CircularProgressIndicator();
//                     } else if (state is GetAllUsersFailState) {
//                       return Text(state.message);
//                     } else if (state is GetAllUsersSuccessState) {
//                       return DefaultDropDown(
//                         controller: usersController,
//                         list: state.getAllUsersResponse.data ?? [],
//                         label: 'Assign Manager',
//                       );
//                     } else {
//                       return Container();
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20,),
//                 CustomFormField(
//                   hintlText:"Name",
//                   controller: nameController,
//                   isPassword: false,
//                   validator: (text) {
//                     if (text!.length <  3 || text.trim().isEmpty|| text.length > 20) {
//                       return 'The Name Should be more than 3 char and less than 20 char';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20,),
//                 CustomFormField(
//                   hintlText:"Email",
//                   controller: emailController,
//                   isPassword: false,
//                   validator: (text) {
//                     if (text == null || text.trim().isEmpty) {
//                       return 'please Enter Email Address';
//                     }
//                     var regex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
//                     if(!regex.hasMatch(text)){
//                       return 'please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20,),
//                 CustomFormField(
//                   hintlText:"Phone",
//                   controller: phoneController,
//                   isPassword: false,
//                   validator: (text) {
//                     if (text == null || text.trim().isEmpty) {
//                       return 'please Enter a Phone Number';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 SizedBox(height: 20,),
//                 CustomFormField(
//                   hintlText:"Password",
//                   controller: passwordController,
//                   isPassword: true,
//                   validator: (text) {
//                     if (text == null ||
//                         text.trim().isEmpty ||
//                         text.length < 6) {
//                       return 'The Password Must at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 40,),
//                 ListTile(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   title: Text('Admin'),
//                   leading: Radio(
//                     value: null,
//                     groupValue: null,
//                     onChanged: (Null? value) {  },
//                   ),
//                 ),
//                 ListTile(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//                   title: Text('Admin'),
//                   leading: Radio(
//                     value: null,
//                     groupValue: null,
//                     onChanged: (Null? value) {  },
//                   ),
//                 ),
//                 ListTile(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//                   title: Text('Admin'),
//                   leading: Radio(
//                     value: null,
//                     groupValue: null,
//                     onChanged: (Null? value) {  },
//                   ),
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: (){
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 17.0),
//                       child: Text('Create',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14
//                         ),),
//                     ),
//                     style: ButtonStyle(
//
//                         backgroundColor: MaterialStatePropertyAll(
//                             Theme.of(context).primaryColor
//                         ),
//                         shape: MaterialStatePropertyAll(
//                             RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
//                         )
//                     ),
//                   ),
//                 )
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//    void updateUser(String token){
//      if (formkey.currentState?.validate() == false) {
//        return;
//      }
//
//
//    }
//
// }
