import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/features/authentication/presentation/widgets/form.dart';
import 'package:pet_care/features/authentication/presentation/widgets/header.dart';
import 'package:pet_care/features/authentication/presentation/widgets/register_footer.dart';
import 'package:pet_care/features/authentication/presentation/widgets/seperator.dart';
import 'package:pet_care/features/authentication/presentation/widgets/social.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      backgroundColor: Colors.white,
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

                SizedBox(height: 12.h),

                buildForm(_emailController,_passwordController,obscurePassword,
                () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                }
                ),

                SizedBox(height: 12.h),

                buildSeparator(),

                SizedBox(height: 12.h),

                buildSocialButtons(),

                SizedBox(height: 24.h),

                buildRegisterFooter(),

                SizedBox(height: 8.h),

            //    _buildHomeIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  
  }
 
 
 





 

  

  

  
 
}