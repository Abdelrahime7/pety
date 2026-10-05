import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/height_widget.dart';
import 'package:pet_care/features/users/presentation/riverpod/user_prvider.dart';
import 'package:pet_care/features/users/presentation/widgets/pofile_header_card.dart';
import 'package:pet_care/features/users/presentation/widgets/premium_promo_card.dart';
import 'package:pet_care/features/users/presentation/widgets/setting_section.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
Widget build(BuildContext context, WidgetRef ref) {
  final userState = ref.watch(userProvider);

  return userState.when(
    loading: () => const Center(
      child: CircularProgressIndicator(),
    ),
    error: (error, stack) => Center(
      child: Text(error.toString()),
    ),
    data: (user) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(
              children: [
                ProfileHeaderCard(user: user),
                HeightSpace(height: 38),
                PremiumPromoCard(),
                HeightSpace(height: 36),
                SettingsSections(user: user),
              ],
            ),
          ),
        ),
      );
    },
  );
}
}