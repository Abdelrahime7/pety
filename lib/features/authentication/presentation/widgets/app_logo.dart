import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogo extends StatelessWidget {
  final double? size;
  final double? iconSize;

  const AppLogo({
    super.key,
    this.size,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final double boxSize = size ?? 52.w;
    final double pawSize = iconSize ?? 26.w;

    return Center(
      child: Container(
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: const Color(0xFF2DD4BF),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2DD4BF).withValues(alpha: 0.35),
              blurRadius: 14,
              spreadRadius: 0,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/icons/paw.png',
          width: pawSize,
          height: pawSize,
          color: Colors.white,
        ),
      ),
    );
  }
}