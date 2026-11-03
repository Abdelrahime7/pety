import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/widgets/app_close_button.dart';
import 'package:pet_care/core/constant/widgets/primary_button.dart';

import 'package:pet_care/features/users/presentation/widgets/feature_item.dart';
import 'package:pet_care/features/users/presentation/widgets/plan_card.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
enum SubscriptionPlan { annual, monthly }

class UpgradeToPremiumScreen extends StatefulWidget {
  const UpgradeToPremiumScreen({super.key});

  @override
  State<UpgradeToPremiumScreen> createState() => _UpgradeToPremiumScreenState();
}

class _UpgradeToPremiumScreenState extends State<UpgradeToPremiumScreen> {
  SubscriptionPlan _selectedPlan = SubscriptionPlan.annual;

  List<Map<String, String>> _features(BuildContext context) => [
    {
      'title': context.l10n.featureUnlimitedPets,
      'subtitle': context.l10n.featureUnlimitedPetsDesc,
    },
    {
      'title': context.l10n.featureCloudBackup,
      'subtitle': context.l10n.featureCloudBackupDesc,
    },
    {
      'title': context.l10n.featureFamilySharing,
      'subtitle': context.l10n.featureFamilySharingDesc,
    },
    {
      'title': context.l10n.featurePdfReports,
      'subtitle': context.l10n.featurePdfReportsDesc,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceContainer,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Bar with Close Button
              Align(
                alignment: AlignmentDirectional.centerStart,
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
                  color: context.colors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  color: context.colors.primary,
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 16.h),

              // Title & Subtitle
              Text(
                context.l10n.upgradeToPremium,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colors.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                context.l10n.premiumSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.4,
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 28.h),

              // DRY Features List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _features(context).length,
                separatorBuilder: (_, _) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final feature = _features(context)[index];
                  return FeatureItem(
                    title: feature[context.l10n.title]!,
                    subtitle: feature['subtitle']!,
                  );
                },
              ),
              SizedBox(height: 28.h),

              // Annual Plan Card
              PlanCard(
                title: context.l10n.annualPlan,
                subtitle: context.l10n.billedYearly,
                price: '\$39.99',
                badgeText: context.l10n.bestValue.toUpperCase(),
                discountTag: context.l10n.savePercent(33),
                isSelected: _selectedPlan == SubscriptionPlan.annual,
                onTap: () =>
                    setState(() => _selectedPlan = SubscriptionPlan.annual),
              ),
              SizedBox(height: 16.h),

              // Monthly Plan Card
              PlanCard(
                title: context.l10n.monthlyPlan,
                subtitle: context.l10n.flexibleBilling,
                price: '\$4.99',
                isSelected: _selectedPlan == SubscriptionPlan.monthly,
                onTap: () =>
                    setState(() => _selectedPlan = SubscriptionPlan.monthly),
              ),
              SizedBox(height: 24.h),

              // Primary Action Button
              AppPrimaryButton(
                text: context.l10n.startFreeTrial,
                onPressed: () {
                  // Handle subscription checkout
                },
              ),
              SizedBox(height: 16.h),

              // Legal / Terms Text
              Text(
                context.l10n.premiumTerms,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.sp,
                  height: 1.4,
                  color: context.colors.onSurfaceVariant,
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