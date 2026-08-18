

  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/widgets/elevated_button.dart';
import 'package:pet_care/features/authentication/presentation/widgets/email.fied.dart';
import 'package:pet_care/features/authentication/presentation/widgets/password_field.dart';

Widget buildForm(TextEditingController emailControler, 
TextEditingController passwordController ,
bool obscurePassword,
void Function () onIconPresed
) 
{
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          buildEmailField(emailControler),

          SizedBox(height: 14.h),

          buildPasswordField(passwordController,
          onIconPresed,
          obscurePassword ,
          ),

          SizedBox(height: 16.h),

          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ActionButton(
              label: 'Sign In',
              onPressed:()=>{},
            )
            ),
        ]
            
              
            ),
          
    
    );
  }
