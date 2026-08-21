import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/widgets/elevated_button.dart';
import 'package:pet_care/core/constant/widgets/height_widget.dart';
import 'package:pet_care/features/authentication/data/user_data.dart';
import 'package:pet_care/features/authentication/presentation/riverpod/auth_provider.dart';
import 'package:pet_care/features/authentication/presentation/widgets/email.fied.dart';
import 'package:pet_care/features/authentication/presentation/widgets/password_field.dart';

class LoginForm extends ConsumerWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onIconPressed;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onIconPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final authState = ref.watch(authProvider);

   _state(ref,context) ;

    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            buildEmailField(emailController),
      
            SizedBox(height: 14.h),
      
            buildPasswordField(
              passwordController,
              onIconPressed,
              obscurePassword,
            ),
      
            HeightSpace(height: 16.h),
      
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ActionButton(
                label: authState.isLoading ? 'Loading...' : 'Sign In',
                onPressed:
                 authState.isLoading
                   
                    ? null
                    : () {
                      if(formKey.currentState!.validate())
                      {
                        ref
                            .read(authProvider.notifier)
                            .login((
                              email: emailController.text,
                              password: passwordController.text,
                            ));
                         
                          
                      }
                      },
  
                      
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}


 void _state(  WidgetRef ref , BuildContext context )
 {
  ref.listen<AsyncValue<UserResponse?>>(
  authProvider,
  (previous, next) {

    if (next.isLoading) {
      return;
    }

    if (next.hasError) {
     

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(next.error.toString()),
        ),
      );

      return;
    }

    if (next.hasValue && next.value != null) {
    appRouter.go(profile);
    }
  },
);
 }