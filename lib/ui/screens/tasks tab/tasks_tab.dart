import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_management_erra_soft_training/ui/screens/update%20department/get%20all%20department%20MVVM/get_all_department_states.dart';

import '../../../providers/auth_provider.dart';
import '../../components/dialog.dart';
import '../../components/user_item.dart';
import '../update department/delete department MVVM/delete_department_cubit.dart';
import '../update department/delete department MVVM/delete_department_states.dart';
import '../update department/get all department MVVM/get_all_department_cubit.dart';
import 'delete user MVVM/delete_user_cubit.dart';
import 'delete user MVVM/delete_user_states.dart';

class UsersTab extends StatelessWidget {
  UsersTab({super.key});
  var getAllDepartmentViewModel = GetAllDepartmentCubit();
  var deleteDepartmentViewModel = DeleteDepartmentCubit();
  var deleteUserViewModel = DeleteUserCubit();
  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider =
        Provider.of<AuthProvider>(context, listen: false);
    getAllDepartmentViewModel.getAllDepartment(token: userProvider.token ?? '');
    return Scaffold(
      body: BlocBuilder<GetAllDepartmentCubit, GetAllDepartmentViewState>(
        bloc: getAllDepartmentViewModel,
        builder: (context, state) {
          if (state is GetAllDepartmentLoadingState) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Color(0xff5A55CA),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 1,
                                      width: 50,
                                      color: Color(0xff7C808A),
                                    ),
                                    Text(
                                      'Loading...',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff7C808A)),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.edit,
                                            color: Color(0xff7C808A)))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 130,
                                width: 195,
                                child: UserItem(
                                  onTap: (){},
                                  color: Colors.orange,
                                  //email: 'dddddddddddddddddddddd',
                                  email: "",
                                  employeeName: 'jj',
                                  phone: 'jj',
                                  userType: 'Manager',
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemBuilder: (context, employeeIndex) {
                                  return UserItem(
                                    onTap: (){},
                                    color: Color(0xff5A55CA),
                                    email: 'jj',
                                    employeeName: 'jj',
                                    phone: 'jj',
                                    userType: 'jj',
                                  );
                                },
                              ),
                            ],
                          );
                        },
                        itemCount: 10,
                      ),
                    )),
              ),
            );
          } else if (state is GetAllDepartmentFailState) {
            return Text(
              state.message,
            );
          } else if (state is GetAllDepartmentSuccessState) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 1,
                                      width: 50,
                                      color: Color(0xff7C808A),
                                    ),
                                    Text(
                                      state.getAllDepartmentResponse
                                              .data?[index].name ??
                                          'ddd',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff7C808A)),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          DialogUtilities.showMessage(context,
                                              'Are you sure you want to Delete this Department',
                                              nigaiveActionName: 'Delete',
                                              nigaiveAction: () {
                                            deleteDepartment(
                                                taskId: state
                                                        .getAllDepartmentResponse
                                                        .data?[index]
                                                        .id ??
                                                    -1,
                                                token:
                                                    userProvider.token ?? '');
                                          }, posstiveActionName: 'No');
                                        },
                                        icon: Icon(Icons.delete_outline,
                                            color: Color(0xff7C808A)))
                                  ],
                                ),
                              ),
                              if(state.getAllDepartmentResponse.data?[index].manager?.name != null)
                              SizedBox(
                              //  height: 144,
                                height: MediaQuery.of(context).size.height*.18,
                              // width: 195,
                                width: MediaQuery.of(context).size.width*.45,
                                child: UserItem(
                                  onTap: (){
                                    deleteUser(token: userProvider.token??'',
                                        userId: state.getAllDepartmentResponse.data?[index].manager?.id??-1);
                                  },
                                  color: Colors.orange,
                                  //email: 'dddddddddddddddddddddd',
                                  email: state.getAllDepartmentResponse
                                          .data?[index].manager?.email ??
                                      "Empty",
                                  employeeName: state.getAllDepartmentResponse
                                          .data?[index].manager?.name ??
                                      'Empty',
                                  phone: state.getAllDepartmentResponse
                                          .data?[index].manager?.phone
                                          .toString() ??
                                      'Empty',
                                  userType: 'Manager',
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.getAllDepartmentResponse
                                    .data?[index].employees?.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 4/3
                                      //mainAxisExtent: 3/3
                                    ),
                                itemBuilder: (context, employeeIndex) {
                                  return UserItem(
                                    onTap:(){
                                      deleteUser(token: userProvider.token??'',
                                          userId: state.getAllDepartmentResponse.data?[index].employees?[index].id??-1);
                                    },
                                    color: Color(0xff5A55CA),
                                    email: state
                                            .getAllDepartmentResponse
                                            .data?[index]
                                            .employees?[employeeIndex]
                                            .email ??
                                        'Empty',
                                    employeeName: state
                                            .getAllDepartmentResponse
                                            .data?[index]
                                            .employees?[employeeIndex]
                                            .name ??
                                        'Empty',
                                    phone: state
                                            .getAllDepartmentResponse
                                            .data?[index]
                                            .employees?[employeeIndex]
                                            .phone
                                            .toString() ??
                                        'Empty',
                                    userType: state
                                            .getAllDepartmentResponse
                                            .data?[index]
                                            .employees?[employeeIndex]
                                            .userType ??
                                        'Empty',
                                  );
                                },
                              ),
                            ],
                          );
                        },
                        itemCount: state.getAllDepartmentResponse.data?.length,
                      ),
                    ),
                    BlocListener<DeleteDepartmentCubit,
                        DeleteDepartmentViewState>(
                      bloc: deleteDepartmentViewModel,
                      listenWhen: (previous, current) {
                        if (previous is DeleteDepartmentLoadingState) {
                          DialogUtilities.hideDialog(context);
                        }
                        if (current is DeleteDepartmentSuccessState ||
                            current is DeleteDepartmentLoadingState ||
                            current is DeleteDepartmentFailState) {
                          return true;
                        }
                        return false;
                      },
                      listener: (context, deleteState) {
                        // event
                        if (deleteState is DeleteDepartmentFailState) {
                          // show message
                          DialogUtilities.showMessage(
                              context, deleteState.message,
                              posstiveActionName: "ok");
                        } else if (deleteState
                            is DeleteDepartmentLoadingState) {
                          //show loading...
                          DialogUtilities.showLoadingDialog(
                              context, "Loading...");
                        } else if (deleteState
                            is DeleteDepartmentSuccessState) {
                          if (deleteState.deleteDepartmentResponse.status ==
                              true) {
                            DialogUtilities.showMessage(
                                context,
                                deleteState.deleteDepartmentResponse.message ??
                                    "",
                                posstiveActionName: "ok",
                                posstiveAction: () async {
                              getAllDepartmentViewModel.getAllDepartment(
                                  token: userProvider.token ?? '');
                              //Navigator.pushNamed(context, UserScreen.routeName);
                            });
                          } else if (deleteState
                                  .deleteDepartmentResponse.status ==
                              false) {
                            DialogUtilities.showMessage(
                              context,
                              deleteState.deleteDepartmentResponse.message ??
                                  '',
                              posstiveActionName: 'Ok',
                            );
                          }
                          // DialogUtilities.hideDialog(context);
                        }
                        // DialogUtilities.hideDialog(context);
                      },
                      child: Container(),
                    ),
                    BlocListener<DeleteUserCubit,
                        DeleteUserViewState>(
                      bloc: deleteUserViewModel,
                      listenWhen: (previous, current) {
                        if (previous is DeleteUserLoadingState) {
                          DialogUtilities.hideDialog(context);
                        }
                        if (current is DeleteUserSuccessState ||
                            current is DeleteUserLoadingState ||
                            current is DeleteUserFailState) {
                          return true;
                        }
                        return false;
                      },
                      listener: (context, deleteState) {
                        // event
                        if (deleteState is DeleteUserFailState) {
                          // show message
                          DialogUtilities.showMessage(
                              context, deleteState.message,
                              posstiveActionName: "ok");
                        } else if (deleteState
                        is DeleteUserLoadingState) {
                          //show loading...
                          DialogUtilities.showLoadingDialog(
                              context, "Loading...");
                        } else if (deleteState
                        is DeleteUserSuccessState) {
                          if (deleteState.deleteUserResponse.status ==
                              true) {
                            DialogUtilities.showMessage(
                                context,
                                deleteState.deleteUserResponse.message ??
                                    "",
                                posstiveActionName: "ok",
                                posstiveAction: () async {
                                  getAllDepartmentViewModel.getAllDepartment(
                                      token: userProvider.token ?? '');
                                  //Navigator.pushNamed(context, UserScreen.routeName);
                                });
                          } else if (deleteState
                              .deleteUserResponse.status ==
                              false) {
                            DialogUtilities.showMessage(
                              context,
                              deleteState.deleteUserResponse.message ??
                                  '',
                              posstiveActionName: 'Ok',
                            );
                          }
                          // DialogUtilities.hideDialog(context);
                        }
                        // DialogUtilities.hideDialog(context);
                      },
                      child: Container(),
                    ),


                  ],
                ));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void deleteDepartment({required String token, required int taskId}) {
    deleteDepartmentViewModel.deleteTask(taskId: taskId, token: token);
  }



  void deleteUser({required String token, required int userId}) {
    deleteUserViewModel.deleteUser(userId: userId, token: token);
  }
}

// BlocListener<DeleteDepartmentCubit, DeleteDepartmentViewState>(
//   bloc: deleteDepartmentViewModel,
//   listenWhen: (previous, current) {
//     if (previous is DeleteDepartmentLoadingState) {
//       DialogUtilities.hideDialog(context);
//     }
//     if (current is DeleteDepartmentSuccessState ||
//         current is DeleteDepartmentLoadingState ||
//         current is DeleteDepartmentFailState) {
//       return true;
//     }
//     return false;
//   },
//
//   listener: (context, deleteState) {
//     // event
//     if (deleteState is DeleteDepartmentFailState) {
//       // show message
//       DialogUtilities.showMessage(
//           context,
//           deleteState.message,
//           posstiveActionName: "ok");
//     }
//     else if (deleteState is DeleteDepartmentLoadingState) {
//       //show loading...
//       DialogUtilities.showLoadingDialog(
//           context,
//           "Loading...");
//     }
//     else if (deleteState is DeleteDepartmentSuccessState) {
//       if (deleteState.deleteDepartmentResponse.status == true) {
//         DialogUtilities.showMessage(context,
//             deleteState.deleteDepartmentResponse.message??"",
//             posstiveActionName: "ok",
//             posstiveAction: () async {
//               getAllDepartmentViewModel.getAllDepartment(token: userProvider.token??'');
//               //Navigator.pushNamed(context, UserScreen.routeName);
//             });
//       }
//       else if(deleteState.deleteDepartmentResponse.status == false) {
//
//         DialogUtilities.showMessage(
//           context,
//           deleteState.deleteDepartmentResponse.message??'',
//           posstiveActionName: 'Ok',
//         );
//       }
//       // DialogUtilities.hideDialog(context);
//     }
//     // DialogUtilities.hideDialog(context);
//   },
//   child: Container(),
//
// ),
