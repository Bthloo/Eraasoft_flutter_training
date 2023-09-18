import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_management_erra_soft_training/api/models/get%20all%20department/GetAllDepartmentResponse.dart';
import '../../api/models/get all department/Data.dart';
import '../../api/models/get all users/Data.dart';
import '../../api/models/get manager model/new/Data.dart';
import '../../providers/auth_provider.dart';


class DepartmentDropDown extends StatelessWidget {
  SingleValueDropDownController controller;
  String label;
  List<AllDepartmentData> list;
  DepartmentDropDown({
    super.key,
    required this.controller,
    required this.label,
    //  required this.hint,
    required this.list,
  });
  @override
  Widget build(BuildContext context) {

    return DropDownTextField(
      textFieldDecoration:  InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(),
      ),
      controller: controller,
      // searchDecoration: InputDecoration(hintText: hint),
      // enableSearch: true,
      dropDownItemCount: list.length,
      dropDownList: list.map<DropDownValueModel>((value) {
        return DropDownValueModel(
            name: value.name??"",
            value: value.id??''
        );
      }).toList(),
      onChanged: (value) {
      },
    );



    //   BlocConsumer<GetAllManagerCubit, GetAllManagerViewState>(
    //   bloc: viewModel,
    //   listener: (context, state) {
    //     // TODO: implement listener
    //   },
    //   builder: (context, state) {
    //     if(state is GetAllManagerLoadingState){
    //       return CircularProgressIndicator();
    //     }
    //     else if(state is GetAllManagerFailState){
    //       return Text(state.message);
    //     }
    //     else if(state is GetAllManagerSuccessState){
    //       return DropDownTextField(
    //         textFieldDecoration: const InputDecoration(
    //           labelText: "Assign Manager",
    //           enabledBorder: OutlineInputBorder(),
    //         ),
    //         controller: controller,
    //        // searchDecoration: InputDecoration(hintText: hint),
    //        // enableSearch: true,
    //         dropDownItemCount: list.length??0,
    //         dropDownList: list.map<DropDownValueModel>((value) {
    //           return DropDownValueModel(
    //             value: value?.id,
    //             name: value?.name??"",
    //           );
    //         }).toList(),
    //         onChanged: (value) {
    //         },
    //       );
    //     }
    //     else {
    //       return Container();
    //     }
    //
    //
    //   },
    // );
  }
}