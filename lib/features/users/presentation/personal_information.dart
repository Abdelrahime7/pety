import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/app_back_button.dart';
import 'package:pet_care/core/constant/widgets/app_save_button.dart';
import 'package:pet_care/features/users/presentation/riverpod/profile_provider.dart';
import 'package:pet_care/features/users/presentation/widgets/profile_picture.dart';
import 'package:pet_care/features/users/presentation/widgets/account_details_group.dart';
import 'package:pet_care/features/users/presentation/widgets/personal_info_form.dart';
import 'package:pet_care/features/users/presentation/widgets/security_action_card.dart';

class ProfileInfoScreen extends ConsumerStatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  ConsumerState<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends ConsumerState<ProfileInfoScreen> {
  late TextEditingController _nameController;
  bool _isSaving = false;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSave() async {
    setState(() => _isSaving = true);

    // Simulate save duration
    await Future.delayed(const Duration(milliseconds: 1200));

    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xFF0F172A),
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'Changes saved successfully',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color surface = Color(0xFFF8FAFC);
    const Color ink = Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: surface,
      appBar: AppBar(
        backgroundColor: surface.withValues(alpha: 0.9),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: UnconstrainedBox(
          child: AppBackButton(onPressed: () => context.pop()),
        ),
        title: const Text(
          'Personal Information',
          style: TextStyle(
            color: ink,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [AppSaveButton(onPressed: _handleSave, isLoading: _isSaving)],
      ),
      body: ref
          .watch(currentUserProvider)
          .when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) =>
                const Center(child: Text('Error loading profile')),
            data: (domainUser) {
              if (!_isInit && domainUser != null) {
                _nameController.text = domainUser.name;
                _isInit = true;
              }

              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        // Profile Photo Component

                        ProfilePictureWidget(
                          size: 112,
                          imageUrl: domainUser?.photoUrl,
                          onEdit: () {
                            // Handle changing robust photo
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'CHANGE PHOTO',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                          ),
                        ),

                        // Form Fields
                        PersonalInfoForm(
                          nameController: _nameController,
                          user: domainUser,
                        ),
                        const SizedBox(height: 32),

                        // Account Details Group
                        AccountDetailsGroup(user: domainUser),
                        const SizedBox(height: 16),

                        // Security Action
                        SecurityActionCard(
                          onTap: () {
                            // Handle password change action
                          },
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),

                  // Loading Overlay identical to AddPetScreen
                  if (_isSaving) ...[
                    Positioned.fill(
                      child: Container(color: Colors.black.withOpacity(0.3)),
                    ),
                    const Center(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
    );
  }
}
