
  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/features/authentication/data/user_data.dart';
import 'package:pet_care/features/authentication/presentation/riverpod/auth_provider.dart';







  void listenToAuthState(WidgetRef ref, BuildContext context) {
    ref.listen<AsyncValue<UserResponse?>>(
      authProvider,
      (previous, next) {
        if (next.isLoading) return;

        if (next.hasError) {
         showNotification(context,next.error.toString(),success: false);
          return;
        }
        

        if (next.hasValue && next.value != null) {
        
          appRouter.go(profile);
        }
      },
    );
  }

  Widget buildFieldLabel(String text) {
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

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showNotification( BuildContext context, String text, { bool success = true, }) 
{
   return ScaffoldMessenger.of(context)
   .showSnackBar( 
      SnackBar( behavior: SnackBarBehavior.floating,
         margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
         padding: const EdgeInsets.symmetric( horizontal: 16, vertical: 14, ),
         shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(14), )
      
        , backgroundColor: const Color(0xFF0F172A), duration: const Duration(seconds: 3),
          content: Row( children:
          [
            Icon( success ? Icons.check_circle_rounded :
              Icons.info_outline_rounded, color: success ?
               AppColors.primary : Colors.white, ),
                const SizedBox(width: 12),
               
                Expanded(
                   child: Text( text, 
                      style: const TextStyle
                      ( color: Colors.white,
                        fontWeight: FontWeight.w500,
                       ),
                      ),
                     ),
                    ]  
                ),
              ),
           );
        }

void resetPassword( BuildContext context,String emailController,WidgetRef ref)async{
   
    final email = emailController.trim();

    final result = await ref
        .read(authProvider.notifier)
        .resetPassword(email);

    switch (result) {
      case Success(:final data):
        showNotification(context,data);

      case Failure(:final message):
        showNotification(context,message,success: false);

      case Cancelled():
        break;
    }
  }