import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/l10n/l10x.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

Widget buildRegisterFooter(
  BuildContext context, {
  required bool isLogin,
  required VoidCallback onTap,
}) {
  return RichText(
    text: TextSpan(
      text: isLogin
          ? context.l10n.noAccountPrompt
          : context.l10n.haveAccountPrompt,
      style: TextStyle(fontSize: 13.sp, color: context.colors.onSurfaceVariant),
      children: [
        TextSpan(
          text: isLogin ? context.l10n.signUp : context.l10n.signIn,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: context.colors.primary,
          ),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ],
    ),
  );
}