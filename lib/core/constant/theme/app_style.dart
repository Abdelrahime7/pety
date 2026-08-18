
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

abstract class AppStyle {


static TextStyle extraboldtitle 
    =GoogleFonts.poppins(
      fontSize: 26,
      fontWeight:FontWeight(800),
      color:AppColors.textPrimary
      );

  static TextStyle title 
    =GoogleFonts.poppins(
      fontSize: 24,
      fontWeight:FontWeight(700),
      color:AppColors.textPrimary
      );
    static TextStyle subtitle 
    =GoogleFonts.poppins(
      fontSize: 16,
            fontWeight:FontWeight(700),

      color:AppColors.textPrimary
      );

static TextStyle reguler14
    =GoogleFonts.poppins(
      fontSize: 14,
            fontWeight:FontWeight(400),

      color:AppColors.textSecondary
      );



static TextStyle reguler14TextButton
    =GoogleFonts.poppins(
      fontSize: 13,
            fontWeight:FontWeight(500),

      color:AppColors.primary
      );
      
    static TextStyle semibold14 
    =GoogleFonts.poppins(
      fontSize: 14,
            fontWeight:FontWeight(600),

      color:AppColors.textPrimary
      );
 static TextStyle whiteSemibold14 
    =GoogleFonts.poppins(
      fontSize: 14,
            fontWeight:FontWeight(600),

      color:AppColors.border
      );

      static TextStyle reguler12 
    =GoogleFonts.poppins(
      fontSize: 12,
            fontWeight:FontWeight(400),

      color:AppColors.textSecondary
      );
  

   static TextStyle reguler10 
    =GoogleFonts.poppins(
      fontSize: 10,
            fontWeight:FontWeight(400),

      color:AppColors.textSecondary
      );
  
}