import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/core/constant/widgets/widht_widget.dart';
import 'package:pet_care/features/users/domain/enums/subscriptionTier.dart';
import 'package:pet_care/features/users/presentation/riverpod/unread_notificatins_provider.dart';
import 'package:pet_care/features/users/presentation/riverpod/user_prvider.dart';
import 'package:pet_care/features/users/presentation/widgets/profile_picture.dart';

class ProfileHeaderCard extends ConsumerWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return user.when(
      loading: () => Container(
        height: 100,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),

      error: (e, st) => const Text(
        'Error loading profile',
      ),

      data: (domainUser) {
        final displayName = domainUser.name;
        final email = domainUser.email;
        final photoUrl = domainUser.photoUrl;

        final isPremium =
            domainUser.subscriptionTier == SubscriptionTier.premium;

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --------------------------------------------------
              // Profile picture
              // --------------------------------------------------

              ProfilePictureWidget(
                imageUrl: photoUrl,
                size: 72,
                onEdit: () async {
                  final picker = ImagePicker();

                  final pickedFile = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );

                  if (pickedFile == null) {
                    return;
                  }

                  final image = File(pickedFile.path);

                  await ref
                      .read(userProvider.notifier)
                      .changeProfilePicture(image);
                },
              ),

              const WidhtSpace(width: 14),

              // --------------------------------------------------
              // User info
              // --------------------------------------------------

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      displayName.isNotEmpty
                          ? displayName
                          : 'Pet Care Member',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.headerName,
                    ),

                    const SizedBox(height: 2),

                    Text(
                      email.isNotEmpty
                          ? email
                          : 'Anonymous User',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.regular13,
                    ),

                    const SizedBox(height: 8),

                    // Plan badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F4F8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPremium
                                ? Icons.workspace_premium
                                : Icons.star_rounded,
                            color: const Color(0xFFF5B731),
                            size: 14,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            isPremium
                                ? 'PREMIUM'
                                : 'FREE PLAN',
                            style: AppStyle.planBadge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const WidhtSpace(width: 8),

              // --------------------------------------------------
              // Notification + Settings
              // --------------------------------------------------

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Notification button
                  Consumer(
                    builder: (context, ref, _) {
                      final unreadCountAsync =
                          ref.watch(
                        unreadNotificationCountProvider,
                      );

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1.2,
                              ),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.notifications_none_rounded,
                                color: Color(0xFF5B6B82),
                                size: 21,
                              ),
                              onPressed: () async {
                                await context.push(notifications
                                );

                                // Refresh unread count
                                // when returning.
                                ref.invalidate(
                                  unreadNotificationCountProvider,
                                );
                              },
                            ),
                          ),

                          // Unread badge
                          unreadCountAsync.when(
                            data: (count) {
                              if (count == 0) {
                                return const SizedBox.shrink();
                              }

                              return Positioned(
                                right: -3,
                                top: -5,
                                child: Container(
                                  constraints:
                                      const BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.surface,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      count > 99
                                          ? '99+'
                                          : '$count',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight:
                                            FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },

                            loading: () =>
                                const SizedBox.shrink(),

                            error: (_, __) =>
                                const SizedBox.shrink(),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(width: 8),

                  // Settings button
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1.2,
                      ),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.settings_rounded,
                        color: Color(0xFF5B6B82),
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}