import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/features/authentication/presentation/validators/password_validator.dart';

Widget buildPasswordField(
  TextEditingController passwordController,
  void Function() onSuffixIconPressed,
  bool obscurePassword,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Password', style: AppStyle.subtitle),

          GestureDetector(
            onTap: _handleForgotPassword,
            child: Text('Forgot?', style: AppStyle.title),
          ),
        ],
      ),

      SizedBox(height: 6.h), //

     
        CustomeTextField(
  controller: passwordController,
  isPassword: obscurePassword,
  hintText: '••••••••••••',
  prefixIcon: Icon(
    Icons.lock_outline,
    size: 18.sp,
    color: AppColors.icon,
  ),
  suffixIcon: Icon(
    obscurePassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined,
    size: 18.sp,
    color: AppColors.secondaryText,
  ),
  onSuffixIconPressed: onSuffixIconPressed ,
  validator: validatePassword,
  
),
        
      ]
      
        );
      
  
  }
 void _handleForgotPassword() {
    // Navigate to forgot password.
  }
      SizedBox(
        height: 48.h,
        child: CustomeTextField(
          controller: passwordController,
          isPassword: obscurePassword,
          hintText: '••••••••••••',
          prefixIcon: Icon(
            Icons.lock_outline,
            size: 18.sp,
            color: AppColors.icon,
          ),
          suffixIcon: Icon(
            obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            size: 18.sp,
            color: AppColors.secondaryText,
          ),
          onSuffixIconPressed: onSuffixIconPressed,
        ),
      ),
    ],
  );
}

void _handleForgotPassword() {
  // Navigate to forgot password.
}
