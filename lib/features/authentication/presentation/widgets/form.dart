import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/core/constant/widgets/height_widget.dart';
import 'package:pet_care/core/constant/widgets/primary_button.dart';
import 'package:pet_care/features/authentication/data/user_data.dart';
import 'package:pet_care/features/authentication/presentation/riverpod/auth_provider.dart';
import 'package:pet_care/features/authentication/presentation/validators/password_validator.dart';
import 'package:pet_care/features/authentication/presentation/widgets/email.fied.dart';
import 'package:pet_care/features/authentication/presentation/widgets/password_field.dart';

class AuthForm extends ConsumerStatefulWidget {
  final bool isLogin;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? nameController;
  final TextEditingController? confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback onIconPressed;
  final VoidCallback? onConfirmIconPressed;

  const AuthForm({
    super.key,
    required this.isLogin,
    required this.emailController,
    required this.passwordController,
    this.nameController,
    this.confirmPasswordController,
    required this.obscurePassword,
    this.obscureConfirmPassword = true,
    required this.onIconPressed,
    this.onConfirmIconPressed,
  });

  @override
  ConsumerState<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    _listenToAuthState(ref, context);

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. FULL NAME (Register only)
            if (!widget.isLogin && widget.nameController != null) ...[
              _buildFieldLabel('FULL NAME'),
              HeightSpace(height: 6.82.h),
              CustomeTextField(
                controller: widget.nameController!,
                keyboardType: TextInputType.name,
                hintText: 'John Doe',
                prefixIcon: Icon(
                  Icons.person_outline_rounded,
                  size: 18.sp,
                  color: AppColors.icon,
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Please enter your name' : null,
              ),
              HeightSpace(height: 14.h),
            ],

            // 2. EMAIL ADDRESS (Both)
            buildEmailField(widget.emailController),
            HeightSpace(height: 14.h),

            // 3. PASSWORD (Both)
            buildPasswordField(
              widget.passwordController,
              widget.onIconPressed,
              widget.obscurePassword,
              showForgotPassword: widget.isLogin,
            ),

            // 4. CONFIRM PASSWORD (Register only)
            if (!widget.isLogin && widget.confirmPasswordController != null) ...[
              HeightSpace(height: 14.h),
              _buildFieldLabel('CONFIRM PASSWORD'),
              HeightSpace(height: 6.82.h),
              CustomeTextField(
                controller: widget.confirmPasswordController!,
                isPassword: widget.obscureConfirmPassword,
                hintText: '••••••••',
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  size: 18.sp,
                  color: AppColors.icon,
                ),
                suffixIcon: Icon(
                  widget.obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18.sp,
                  color: AppColors.secondaryText,
                ),
                onSuffixIconPressed: widget.onConfirmIconPressed,
                validator: (value) {
                  if (value != widget.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return validatePassword(value);
                },
              ),
            ],

            HeightSpace(height: 16.h),

            // 5. SUBMIT BUTTON
            SizedBox(
              width: double.infinity,
              height: 49.5.h,
              child: AppPrimaryButton(
                text: authState.isLoading
                    ? 'Loading...'
                    : (widget.isLogin ? 'Sign In' : 'Sign Up'),
                onPressed: authState.isLoading ? null : _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(authProvider.notifier);
    if (widget.isLogin) {
      notifier.login((
        email: widget.emailController.text.trim(),
        password: widget.passwordController.text.trim(),
      ));
    } else {
      notifier.register((
        email: widget.emailController.text.trim(),
        password: widget.passwordController.text.trim(),
      ));
    }
  }

  void _listenToAuthState(WidgetRef ref, BuildContext context) {
    ref.listen<AsyncValue<UserResponse?>>(
      authProvider,
      (previous, next) {
        if (next.isLoading) return;

        if (next.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.error.toString())),
          );
          return;
        }

        if (next.hasValue && next.value != null) {
          appRouter.go(profile);
        }
      },
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: AppStyle.tileTitle.copyWith(
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: const Color(0xFF8A94A6),
      ),
    );
  }
}