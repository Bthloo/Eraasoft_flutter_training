import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:task_management_erra_soft_training/ui/screens/add%20department/MVVM/add_department_cubit.dart';
import 'package:task_management_erra_soft_training/ui/screens/add%20department/MVVM/add_department_states.dart';

import '../../../providers/auth_provider.dart';
import '../../components/custom_form_field.dart';
import '../../components/dialog.dart';
import '../home screen/home_screen.dart';

class AddDepartment extends StatelessWidget {
   AddDepartment({super.key});
  static const String routeName = 'addDepartmentScreen';
  final formkey = GlobalKey<FormState>();
   final nameController = TextEditingController();
  var viewModel = AddDepartmentCubit();
  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider = Provider.of<AuthProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(),
      body:  BlocConsumer<AddDepartmentCubit, AddDepartmentViewState>(
    bloc: viewModel,
    listenWhen: (previous, current) {
    if (previous is AddDepartmentLoadingState) {
    DialogUtilities.hideDialog(context);
    }
    if (current is AddDepartmentSuccessState ||
    current is AddDepartmentLoadingState ||
    current is AddDepartmentFailState) {
    return true;
    }
    return false;
    },
    buildWhen: (previous, current) {
    if (current is AddDepartmentInitialState) return true;
    return false;
    },
    listener: (context, state) {
    // event
    if (state is AddDepartmentFailState) {
    // show message
    DialogUtilities.showMessage(
    context,
    state.message,
    posstiveActionName: "ok");
    } else if (state is AddDepartmentLoadingState) {
    //show loading...
    DialogUtilities.showLoadingDialog(
    context,
    "Loading...");
    } else if (state is AddDepartmentSuccessState) {
      if (state.addDepartmentResponse?.message =='Created') {
    DialogUtilities.showMessage(context,
        'Added Successfully',
        posstiveActionName: "ok",
        posstiveAction: () async {
    Navigator.of(context)
        .pushReplacementNamed(HomeSceen.routeName);
    });
    }
    else if(state.addDepartmentResponse?.status == false) {
    DialogUtilities.showMessage(
    context,
    'Something Went Wrong',
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
      Text(' New Department!',style: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.bold
      ),
      ),
      SizedBox(height: 20,),
      Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text('''Create a new department now and
assign a manager to start the work!''',style: TextStyle(
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
    SizedBox(
    width: double.infinity,
    child: ElevatedButton(
    onPressed: (){
      addDepartment(userProvider.token??'');
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
   void addDepartment(String token) async {
     if (formkey.currentState?.validate() == false) {
       return;
     }

     viewModel.addDepartment(name: nameController.text, token: token);

   }

}
