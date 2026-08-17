
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton  extends StatelessWidget {

final String ? text;
final Color ?color;
final Color ?textColor;
final double ?width;
final double ?height;
final double ?radius;
final double ?fontSize;
final  void Function()  onPressed;

  const PrimaryButton( {this.text, 
   this.color,  this.width,  this.height,
    this.radius,  required this.onPressed,  this.textColor, super.key, this.fontSize}); 

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color??Color(0xff617AFD),
        minimumSize: Size(width??313.w, height??56.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius??8.r)
        )
      ),
      onPressed: onPressed ,
       child: Text(text ??"",style: TextStyle(fontSize:fontSize??12.sp,color: textColor??Colors.white))
      
       
       
    );
  }
}