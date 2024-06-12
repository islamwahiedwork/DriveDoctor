import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
 final String text;
 final  Color firstLinearGradientColor;
 final  Color secondLinearGradientColor;

  final void Function() onTap;
   const AppButton({super.key,required this.text, required this.onTap, required this.firstLinearGradientColor, required this.secondLinearGradientColor});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
          height: 50.h,
          width: 320.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient:   LinearGradient(
                colors: [firstLinearGradientColor, secondLinearGradientColor]),
          ),


          child:   Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
