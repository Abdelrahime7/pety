import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/features/users/presentation/riverpod/unread_notificatins_provider.dart';



class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCountAsync = ref.watch(unreadNotificationCountProvider);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning 👋',
                style: AppStyle.regular14,
              ),
              SizedBox(height: 4.h),
              Text(
                'Hello, Pet Parent!',
                style: AppStyle.title.copyWith(
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Let’s make your pet happy today.',
                style: AppStyle.regular12,
              ),
            ],
          ),
        ),

        SizedBox(width: 12.w),

         _NotificationButton(
          unreadCountAsync: unreadCountAsync,
          onPressed: () async {
            await appRouter.push(notifications);
            ref.invalidate(unreadNotificationCountProvider);
          }
         )
      ],
    );
  }
}


class _NotificationButton extends StatelessWidget {
  final AsyncValue<int> unreadCountAsync;
  final VoidCallback onPressed;

  const _NotificationButton({
    required this.unreadCountAsync,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 46.w,
          height: 46.w,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.border),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.notifications_none_rounded,
              size: 23.sp,
              color: AppColors.text,
            ),
          ),
        ),
        unreadCountAsync.when(
          data: (count) {
            if (count == 0) return const SizedBox.shrink();

            return Positioned(
              right: -3,
              top: -5,
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.surface,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    count > 99 ? '99+' : '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}