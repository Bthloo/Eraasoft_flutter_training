
import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);

class CustomFormField extends StatelessWidget {
  String hintlText;

  MyValidator validator;
  TextEditingController controller;
  TextInputType keyboardType;
int minLines ;
int maxLines ;
  IconButton? suffix;
  bool isPassword;

  CustomFormField(
      {super.key,
      required this.hintlText,
      required this.validator,
      required this.controller,
        this.minLines = 1,
        this.maxLines = 10,
      this.keyboardType = TextInputType.text,
      this.suffix,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      textAlignVertical: TextAlignVertical.top,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isPassword,
      //textDirection: TextDirection,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15)),
        suffixIcon: suffix,
        //labelText: 'Email',
        hintText: hintlText,
        //suffixIcon: ,
        hintStyle: TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
