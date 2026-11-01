import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pet_care/features/users/domain/entity/user.dart';
import 'package:pet_care/features/users/domain/enums/subscriptionTier.dart';

class AccountDetailsGroup extends StatelessWidget {
  final User? user;

  const AccountDetailsGroup({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final Color inkSoft = context.colors.onSurfaceVariant;
    final Color ink = context.colors.onSurface;
    final Color inkMuted = context.colors.onSurfaceVariant;

    final isPremium = user?.subscriptionTier == SubscriptionTier.premium;

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: context.colors.outlineVariant),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4),
        ],
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
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        isPremium
                            ? Icons.workspace_premium
                            : Icons.star_rounded,
                        color: const Color(0xFFF59E0B),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SUBSCRIPTION',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: inkSoft,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isPremium ? 'Premium Plan' : 'Free Plan',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ink,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (!isPremium)
                  InkWell(
                    onTap: () => context.push('/upgrade-to-premium'),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Upgrade',
                        style: TextStyle(
                          color: context.colors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(height: 1, color: context.colors.surface),

          // Member Since
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: context.colors.outlineVariant,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.calendar_today, color: inkMuted, size: 16),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MEMBER SINCE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: inkSoft,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user != null
                          ? "${user!.createdAt.month}/${user!.createdAt.year}"
                          : "October 12, 2023",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ink,
                      ),
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
