
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryOutlinedButton  extends StatelessWidget {

final String ? text;
final Color ?color;
final Color ?textColor;
final double ?fontSize;
final double ?width;
final double ?height;
final double ?radius;
final  void Function()  onPressed;

  const PrimaryOutlinedButton( {this.text, 
   this.color,  this.width,  this.height,
    this.radius,  required this.onPressed,  this.textColor,this.fontSize, super.key}); 

  @override
  Widget build(BuildContext context) {
   return OutlinedButton(
   
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      backgroundColor: color??Colors.white,
      minimumSize: Size(width??313.w, height??56.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius??8.r)
      )
      
     ), 
      child: Text(text ??" ",style:  TextStyle(fontSize:fontSize??12.sp,color: textColor??Colors.blue)),
   );


  }
}