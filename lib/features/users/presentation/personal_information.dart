import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/core/constant/widgets/app_back_button.dart';
import 'package:pet_care/core/constant/widgets/app_save_button.dart';
import 'package:pet_care/features/authentication/presentation/helpers/helpers.dart';
import 'package:pet_care/features/authentication/presentation/riverpod/auth_provider.dart';
import 'package:pet_care/features/users/data/user_data.dart';
import 'package:pet_care/features/users/presentation/riverpod/user_prvider.dart';
import 'package:pet_care/features/users/presentation/widgets/account_details_group.dart';
import 'package:pet_care/features/users/presentation/widgets/logout_card.dart';
import 'package:pet_care/features/users/presentation/widgets/personal_info_form.dart';
import 'package:pet_care/features/users/presentation/widgets/profile_picture.dart';
import 'package:pet_care/features/users/presentation/widgets/security_action_card.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class ProfileInfoScreen extends ConsumerStatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  ConsumerState<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends ConsumerState<ProfileInfoScreen> {
  late TextEditingController _nameController;
  bool _isSaving = false;
  bool _isInit = false;
  File? imageFile;

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

  Future<void> _handleSave(UserRequest request) async {
    setState(() => _isSaving = true);
    final data = toPatchMap(request);
    try {
      final result = await ref
          .read(userProvider.notifier)
          .patchUser(request.uid!, data);

      switch (result) {
        case Success<void>():
          if (mounted) {
            showNotification(context, context.l10n.profileUpdated);
          }

        case Failure<void>(:final message):
          if (mounted) {
            showNotification(context, message, success: false);
          }

        case Cancelled<void>():
          if (mounted) {
            showNotification(context, context.l10n.profileUpdateCancelled);
          }
      }
    } catch (e) {
      if (mounted) {
        showNotification(context, context.l10n.somethingWentWrong);
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _onSavePressed() async {
    final user = ref.read(userProvider).value;
    if (user == null) return;

    String? photoUrl;

    // 1. Upload selected image if there is one
    if (imageFile != null) {
      final uniquePublicId =
          '${user.userId}_${DateTime.now().millisecondsSinceEpoch}';
      final imageResult = await ref
          .read(userProvider.notifier)
          .uploadImage(imageFile!, uniquePublicId);

      if (imageResult is Success<String>) {
        photoUrl = imageResult.data;
      } else {
        return;
      }
    }

    // 2. Create request
    final UserRequest request = (
      uid: user.userId,
      email: null,
      password: null,
      name: _nameController.text.trim(),
      photoUrl: photoUrl,
      subscriptionTier: null,
    );

    // 3. Save everything
    await _handleSave(request);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile == null) return;

    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProvider);
    final colors = context.colors;

    return Scaffold(
      // Background comes from the theme.
      appBar: AppBar(
        leading: UnconstrainedBox(
          child: AppBackButton(onPressed: () => context.pop()),
        ),
        title: Text(
          context.l10n.personalInformation,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          AppSaveButton(onPressed: _onSavePressed, isLoading: _isSaving),
        ],
      ),
      body: currentUser.when(
        loading: () =>
            Center(child: CircularProgressIndicator(color: colors.primary)),
        error: (e, st) => Center(
          child: Text(
            context.l10n.errorLoadingProfile,
            style: TextStyle(color: colors.onSurfaceVariant),
          ),
        ),
        data: (domainUser) {
          if (!_isInit) {
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
                      imageFile: imageFile,
                      size: 112,
                      imageUrl: domainUser.photoUrl,
                      onEdit: _pickImage,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.changePhoto.toUpperCase(),
                      style: TextStyle(
                        color: colors.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: context.tracking(1.0),
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
                      onTap: () async {
                        final result = await ref
                            .read(authProvider.notifier)
                            .resetPassword(domainUser.email);

                        if (!context.mounted) return;

                        switch (result) {
                          case Success(:final data):
                            showNotification(context, data);

                          case Failure(:final message):
                            showNotification(context, message, success: false);

                          case Cancelled():
                            break;
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    LogoutActionCard(
                      onTap: () async {
                        final result = await ref
                            .read(authProvider.notifier)
                            .logout();

                        if (result is Success<void>) {
                          if (context.mounted) {
                            appRouter.go('/login');
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),

              // Loading overlay
              if (_isSaving) ...[
                Positioned.fill(
                  child: Container(color: Colors.black.withValues(alpha: 0.3)),
                ),
                Center(
                  child: Card(
                    color: colors.surfaceContainerHigh,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: CircularProgressIndicator(color: colors.primary),
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