import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

Widget buildSocialButtons(
  BuildContext context, {
  required VoidCallback onGooglePressed,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: Row(
      children: [
        Expanded(
          child: _socialButton(
            context,
            icon: Image.asset(
              'assets/icons/google.png',
              width: 18.w,
              height: 18.h,
            ),
            label: 'Google',
            onPressed: onGooglePressed,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _socialButton(
            context,
            icon: Icon(
              Icons.apple,
              size: 22.sp,
              color: context.colors.onSurface,
            ),
            label: 'Apple',
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}

Widget _socialButton(
  BuildContext context, {
  required Widget icon,
  required String label,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    height: 48.h,
    child: OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14.sp,
          height: 17 / 14,
          fontWeight: FontWeight.w600,
          color: context.colors.onSurface,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.zero,
        side: BorderSide(color: context.colors.outlineVariant),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    ),
  );
}
