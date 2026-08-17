

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

class CustomeTextField extends StatelessWidget {
  final String? hintText;
 final Widget ?sufixIcon ;
 final bool ?ispassword;
 final  double ? width ; 
 final double ? height ;
 final TextEditingController controller;
 final String? Function(String?)? validator;

  const CustomeTextField  ({super.key, this.hintText, 
  this.sufixIcon, this.ispassword, this.width,
   this.height, required this.controller , this.validator
});

  @override
  Widget build(BuildContext context) {
    return 
    SizedBox(
      width:width ??331.w,
      height: height ??50.h,
      

     child:  TextFormField(
      controller: controller,
      validator: validator,

      obscureText: ispassword??false,
      cursorColor: AppColors.primary,
      autofocus: false,
      
      decoration: InputDecoration(
      filled: true,
        fillColor: Color(0xffF7F8F9),
        suffixIcon: sufixIcon,
        hintText: hintText ?? "",
        hintStyle: AppStyle.subtitle,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xffE8ECF4),width: 1)
        ,
        

        )  ,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide:  BorderSide(color:AppColors.primary,width: 1)
      
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r), 
      borderSide:  BorderSide(color:Colors.red,width: 1)
      
    )
    )
     )
    );
  }
}  