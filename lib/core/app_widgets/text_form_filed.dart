import 'package:flutter/material.dart';

class AppTextFormFiled extends StatelessWidget {
 final TextEditingController controller;
 final bool isObscureText;
 final Widget suffixWidget;
 final String hintText;
 final bool isReadOnly;
 final  String? Function(String?) validatorFunction;

  const AppTextFormFiled({
    super.key,
    required this.controller,
    required this.isObscureText,
    required this.suffixWidget,
    required this.hintText,
    required this.isReadOnly,
    required this.validatorFunction
  });

  @override
  Widget build(BuildContext context) {
    return    TextFormField(
      controller: controller,
      obscureText:
      isObscureText,
      readOnly: isReadOnly,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
          suffixIcon: suffixWidget,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Colors.grey, fontSize: 14),
          border: const UnderlineInputBorder(
              borderSide:
              BorderSide(color: Colors.blueAccent))),
      validator: validatorFunction,
    );
  }
}
