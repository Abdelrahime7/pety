import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

class PremiumPromoCard extends StatelessWidget {
  const PremiumPromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        gradient: AppColors.premiumCardGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.tealLight.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Row: Tag + Crown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Text(
                  'PETCARE+ PREMIUM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              Image.asset(
                'assets/icons/premium.png',
                width: 28.0,
                height: 28.0,
                color: const Color(0xFFFBBF24),
              ),
            ],
          ),
          const SizedBox(height: 20.0),

          // Main Headline
          const Text(
            'Get Unlimited Care',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 10.0),

          // Subtitle / Description
          Text(
            'Unlock multi-pet support, cloud backup,\nand health export features.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14.0,
              height: 1.4,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 24.0),

          // Action Button
          SizedBox(
            width: double.infinity,
            height: 52.0,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text(
                'Upgrade Now — \$4.99/mo',
                style: TextStyle(
                  color: AppColors.tealDark,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
