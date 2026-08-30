import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/app_back_button.dart';
import 'package:pet_care/core/constant/widgets/app_save_button.dart';
import 'package:pet_care/features/authentication/presentation/helpers/helpers.dart';
import 'package:pet_care/features/authentication/presentation/riverpod/auth_provider.dart';
import 'package:pet_care/features/users/data/user_data.dart';
import 'package:pet_care/features/users/presentation/riverpod/user_prvider.dart';
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
  File ?imageFile;

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
      debugPrint("WWWWWWWWWWWWWW ARE HER : ${request.photoUrl}");

  setState(() => _isSaving = true);
  final data = toPatchMap (request);
  try {

    final result = await ref
        .read(userProvider.notifier)
        .patchUser(request.uid!,data);

    switch (result) {
      case Success<void>():
        if (mounted) {
          savedNotifications(
            'Profile updated successfully',
            context,
          );
        }

      case Failure<void>(:final message):
        if (mounted) {
          savedNotifications(
            message,
            context,
          );
        }

      case Cancelled<void>():
        if (mounted) {
          savedNotifications(
            'Profile update cancelled',
            context,
          );
        }
    }
  } catch (e) {

   debugPrint('Exception: $e');
    if (mounted) {
      savedNotifications(
        'Something went wrong',
        context,
      );
    }
  } finally {
    if (mounted) {
      setState(() => _isSaving = false);
    }
  }
}
  @override
  Widget build(BuildContext context) {
   final currentUser =  ref.watch(userProvider);

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
        actions: [
          AppSaveButton(
    onPressed: () async {
      final user = currentUser.value;

      if (user == null) return;

      String? photoUrl;

      // 1. Upload selected image if there is one
      if (imageFile != null) {
        final imageResult = await ref
            .read(userProvider.notifier)
            .uploadImage(
              imageFile!,
              user.userId,
            );

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
    },
    isLoading: _isSaving,
  ),
],
        
         
      ),

      body: currentUser
          .when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) =>
                const Center(child: Text('Error loading profile')),
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
                          onEdit:() async { 
                            final picker = ImagePicker();
 
                             final pickedFile = await picker.pickImage(
                             source: ImageSource.gallery,
                                imageQuality: 80,
                             );

                             if (pickedFile == null) {
                                  return;
                                  }

                            setState(() {
                                imageFile = File(pickedFile.path);
                            });
                              
                        
                        //    ref.read(userProvider.notifier).changeProfilePicture(image);
                        
                          }
                            
                          
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
                          onTap: () async {
                             final result = await ref
                                  .read(authProvider.notifier)
                                  .resetPassword(currentUser.value!.email);

                             switch (result) {
                                case Success(:final data):
                                   showSuccessNotification(context,data);

                                case Failure(:final message):
                                   showSuccessNotification(context,message);

                               case Cancelled():
                                  break;
                             }
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
 

 void savedNotifications(String text,context)
 {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xFF0F172A),
          content: Row(
            children:  [
              Icon(Icons.check_circle, color: AppColors.primary),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

 } 