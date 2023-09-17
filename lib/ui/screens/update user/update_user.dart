import 'package:flutter/material.dart';

import '../../components/custom_form_field.dart';

class UpdateUser extends StatelessWidget {
   UpdateUser({super.key});
  static const String routeName = 'updateUserScreen';
  final formkey = GlobalKey<FormState>();
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final nameController = TextEditingController();
   final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  title: Text('Admin'),
                  leading: Radio(
                    value: null,
                    groupValue: null,
                    onChanged: (Null? value) {  },
                  ),
                ),
                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  title: Text('Admin'),
                  leading: Radio(
                    value: null,
                    groupValue: null,
                    onChanged: (Null? value) {  },
                  ),
                ),
                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  title: Text('Admin'),
                  leading: Radio(
                    value: null,
                    groupValue: null,
                    onChanged: (Null? value) {  },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      adduser(context);
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
      ),
    );
  }
   void adduser(BuildContext context) async {
     if (formkey.currentState?.validate() == false) {
       return;
     }

   }

}
