

 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';

Widget buildEmailField(TextEditingController emailControler) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: AppStyle.semibold14
        ),

        SizedBox(height: 6.h),

        SizedBox(
          height: 48.h,
          child: CustomeTextField(
            controller: emailControler,
            keyboardType: TextInputType.emailAddress,
            
              hintText: 'jessica.thorne@email.com',
              prefixIcon: Icon(
                Icons.mail_outline,
                size: 18.sp,
                color: AppColors.icon,
              ),
          
            ),
          ),
      ]
    );
      
  
  }