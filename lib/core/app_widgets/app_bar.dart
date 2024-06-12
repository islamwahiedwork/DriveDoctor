import 'package:drive_doctor/core/app_widgets/change_lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
 final Widget titleWidget;
 final  void Function()? onTap;
 final  bool isShowBackButton;
  const CustomAppBar({super.key, required this.titleWidget, this.onTap, required this.isShowBackButton});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        SizedBox(height: 5.h,),
        // Sign up Text
        Padding(
          padding:   EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              isShowBackButton?
              InkWell(
                  onTap:onTap,
                  child: const Icon(Icons.arrow_back_ios,color: Colors.white)) : const SizedBox(),
              titleWidget,

              SizedBox(width: 13.w,),

            ],
          ),
        ),
        SizedBox(
          height: 35.h,
        ),
      ],
    );
  }
}
