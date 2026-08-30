


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;
  const BottomNavBar({super.key, required this.currentIndex 
, this.onTap});  


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary ,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.abc_outlined),
          label: 'Wallet',
        ),
         BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              color:AppColors.primary,
              shape: BoxShape.circle

            ),
         width:50.w,
         height: 50.w,
          child:Icon(Icons.add,
          color: Colors.white,
          
          )
          ),
          label: "Add"
        ),
        BottomNavigationBarItem(
          icon: 
                Icon(Icons.abc_outlined),
          label: 'Stats',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }


 }