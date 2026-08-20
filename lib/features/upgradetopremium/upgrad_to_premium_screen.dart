import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/app_close_button.dart';
import 'package:pet_care/core/constant/widgets/height_widget.dart';
import 'package:pet_care/core/constant/widgets/primary_button.dart';

import 'package:pet_care/features/upgradetopremium/widgets/feature_item.dart';
import 'package:pet_care/features/upgradetopremium/widgets/plan_card.dart';

enum SubscriptionPlan { annual, monthly }

class UpgradeToPremiumScreen extends StatefulWidget {
  const UpgradeToPremiumScreen({super.key});

  @override
  State<UpgradeToPremiumScreen> createState() => _UpgradeToPremiumScreenState();
}

class _UpgradeToPremiumScreenState extends State<UpgradeToPremiumScreen> {
  SubscriptionPlan _selectedPlan = SubscriptionPlan.annual;

  static const List<Map<String, String>> _features = [
    {
      'title': 'Unlimited Pets',
      'subtitle': 'Track as many pets as you have in one account.',
    },
    {
      'title': 'Cloud Backup & Sync',
      'subtitle': 'Never lose your pet\'s medical records or data.',
    },
    {
      'title': 'Family Sharing',
      'subtitle': 'Add partners or caregivers to manage pets together.',
    },
    {
      'title': 'PDF Health Reports',
      'subtitle': 'Export records to share with vets or insurance.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Bar with Close Button
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: const AppCloseButton(),
                ),
              ),
              // Crown Header Icon
              Container(
                width: 64.r,
                height: 64.r,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  color: AppColors.primary,
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 16.h),

              // Title & Subtitle
              Text(
                'Upgrade to Premium',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Give your pets the best care with\nadvanced tracking and insights.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.4,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 28.h),

              // DRY Features List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _features.length,
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final feature = _features[index];
                  return FeatureItem(
                    title: feature['title']!,
                    subtitle: feature['subtitle']!,
                  );
                },
              ),
              SizedBox(height: 28.h),

              // Annual Plan Card
              PlanCard(
                title: 'Annual Plan',
                subtitle: 'Billed yearly',
                price: '\$39.99',
                badgeText: 'BEST VALUE',
                discountTag: 'Save 33%',
                isSelected: _selectedPlan == SubscriptionPlan.annual,
                onTap: () => setState(() => _selectedPlan = SubscriptionPlan.annual),
              ),
              SizedBox(height: 16.h),

              // Monthly Plan Card
              PlanCard(
                title: 'Monthly Plan',
                subtitle: 'Flexible billing',
                price: '\$4.99',
                isSelected: _selectedPlan == SubscriptionPlan.monthly,
                onTap: () => setState(() => _selectedPlan = SubscriptionPlan.monthly),
              ),
              SizedBox(height: 24.h),

              // Primary Action Button
              AppPrimaryButton(
                text: 'Start 7-Day Free Trial',
                onPressed: () {
                  // Handle subscription checkout
                },
              ),
              SizedBox(height: 16.h),

              // Legal / Terms Text
              Text(
                'By continuing, you agree to our Terms of Service and\nPrivacy Policy. Cancel anytime.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.sp,
                  height: 1.4,
                  color: AppColors.textMuted,
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}