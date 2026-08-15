
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

abstract class AppStyle {
  static TextStyle title 
    =GoogleFonts.poppins(
      fontSize: 24,
      color:AppColors.textPrimary
      );
    static TextStyle subtitle 
    =GoogleFonts.poppins(
      fontSize: 16,
      color:AppColors.textSecondary
      );


      
    
  
}