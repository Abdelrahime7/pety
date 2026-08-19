import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/height_widget.dart';
import 'package:pet_care/features/home_screen/widgets/pofile_header_card.dart';
import 'package:pet_care/features/home_screen/widgets/premium_promo_card.dart';
import 'package:pet_care/features/home_screen/widgets/setting_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              ProfileHeaderCard(),
              HeightSpace(height: 38),
              PremiumPromoCard(),
              HeightSpace(height: 36),
              SettingsSections(),
            ],
          ),
        ),
      ),
    );
  }
}
