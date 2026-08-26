import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/authentication/domain/entity/user.dart';
import 'package:pet_care/features/authentication/domain/enums/subscriptionTier.dart';

class AccountDetailsGroup extends StatelessWidget {
  final User? user;

  const AccountDetailsGroup({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    const Color inkSoft = Color(0xFF94A3B8);
    const Color ink = Color(0xFF0F172A);
    const Color inkMuted = Color(0xFF64748B);
    
    final isPremium = user?.subscriptionTier == SubscriptionTier.premium;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
      ),
      child: Column(
        children: [
          // Subscription
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(16)),
                      child: Icon(isPremium ? Icons.workspace_premium : Icons.star_rounded, color: const Color(0xFFF59E0B), size: 18),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('SUBSCRIPTION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: inkSoft, letterSpacing: 1.0)),
                        const SizedBox(height: 2),
                        Text(isPremium ? 'Premium Plan' : 'Free Plan', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: ink)),
                      ],
                    ),
                  ],
                ),
                if (!isPremium)
                  InkWell(
                    onTap: () => context.push('/upgrade-to-premium'),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('Upgrade', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF8FAFC)),

          // Member Since
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(16)),
                  child: const Icon(Icons.calendar_today, color: inkMuted, size: 16),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('MEMBER SINCE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: inkSoft, letterSpacing: 1.0)),
                    const SizedBox(height: 2),
                    Text(
                      user != null
                      ? "${user!.createdAt.month}/${user!.createdAt.year}"
                      : "October 12, 2023",
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: ink),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
