import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/height_widget.dart';
import 'package:pet_care/features/authentication/presentation/riverpod/auth_provider.dart';
import 'package:pet_care/features/authentication/presentation/widgets/form.dart';
import 'package:pet_care/features/authentication/presentation/widgets/header.dart';
import 'package:pet_care/features/authentication/presentation/widgets/register_footer.dart';
import 'package:pet_care/features/authentication/presentation/widgets/seperator.dart';
import 'package:pet_care/features/authentication/presentation/widgets/social.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
 ConsumerState<LoginScreen> createState() => _LoginScreenState();}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool obscurePassword = true;

  

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 16.h,
            ),
            child: Column(
              children: [
                buildHeader(),

                HeightSpace(height: 12.h),

                LoginForm( emailController:_emailController,
                     passwordController: _passwordController,
                     obscurePassword:  obscurePassword,
                     onIconPressed: 
                () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                }                
                ),
            
                HeightSpace(height: 12.h),

                buildSeparator(),

                HeightSpace(height: 12.h),

                buildSocialButtons(
                  onGooglePressed: () {
    ref.read(authProvider.notifier).loginWithGoogle();
  },
  

                ),

                HeightSpace(height: 24.h),

                buildRegisterFooter(),

                HeightSpace(height: 8.h),

            //    _buildHomeIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  
  } 


  }
  

 





 

  

  

  
 
