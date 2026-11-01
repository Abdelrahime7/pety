import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/features/authentication/presentation/validators/email_validator.dart';

Widget buildEmailField(
  TextEditingController emailController,
  BuildContext context,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'EMAIL ADDRESS',
        style: context.style.tileTitle.copyWith(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: context.colors.onSurfaceVariant,
        ),
      ),
      SizedBox(height: 6.82.h),
      CustomeTextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        hintText: 'name@example.com',
        prefixIcon: Icon(
          Icons.mail_outline_rounded,
          size: 18.sp,
          color: context.colors.onSurfaceVariant,
        ),
        validator: validateEmail,
      ),
    ],
  );
}
