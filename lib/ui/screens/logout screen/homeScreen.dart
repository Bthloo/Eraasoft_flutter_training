import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../components/dialog.dart';
import '../login/login_screen.dart';
import 'MVVM/logout_cubit.dart';
import 'MVVM/logout_states.dart';

class LogoutScreen extends StatelessWidget {
   LogoutScreen({super.key});
   var viewModel = LogoutCubit();
static const String routeName = 'logout';
  @override
  Widget build(BuildContext context) {
    AuthProvider userProvider = Provider.of<AuthProvider>(context);
   // userProvider.getToken();
    print(userProvider.token);
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LogoutCubit, LogoutViewState>(
    bloc: viewModel,
    listenWhen: (previous, current) {
      if (previous is LogoutLoadingState) {
        DialogUtilities.hideDialog(context);
      }
      if (current is LogoutSuccessState ||
          current is LogoutLoadingState ||
          current is LogoutFailState) {
        return true;
      }
      return false;
    },
    buildWhen: (previous, current) {
      if (current is LogoutInitialState) return true;
      return false;
    },
    listener: (context, state) {
      // event
      if (state is LogoutFailState) {
        // show message
        DialogUtilities.showMessage(
            context,
            state.message,
            posstiveActionName: "ok");
      } else if (state is LogoutLoadingState) {
        //show loading...
        DialogUtilities.showLoadingDialog(
            context,
            "Loading...");
      } else if (state is LogoutSuccessState) {
        if (state.logoutResponse.status == true) {

          DialogUtilities.showMessage(context, "Logout Successfully",
              posstiveActionName: "ok", posstiveAction: () async {
                final storage = FlutterSecureStorage();
                await storage.delete(key: 'token');
                userProvider.token = '';
                //  writeSecureStorage(state.logInResponse.data?.token);
                Navigator.of(context)
                    .pushReplacementNamed(LogInScreen.routeName);
              });
        } else if (state.logoutResponse.status == false) {
          DialogUtilities.showMessage(
            context,
            " ${state.logoutResponse.message}",
            posstiveActionName: state.logoutResponse.message,
          );
        }
        // show dialog
        // navigate to home screen
      }
    },
    builder: (context, state){
      return   Column(
        children: [
          Center(
            child: ElevatedButton(
                onPressed: (){
                  logout(userProvider.token);
                },
                child: Text('Logout')),
          )
        ],
      );
    },
    ),

    );
  }

  logout(token){
    viewModel.logout(token: token);
  }
}
