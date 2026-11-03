import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/notifications/domain/entities/notification.dart';
import 'package:pet_care/features/notifications/domain/enums/notification_type.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class NotificationCard extends StatelessWidget {
  final Notification notification;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  IconData _getIcon() {
    switch (notification.type) {
      case NotificationType.appointment:
        return Icons.calendar_month_rounded;
      case NotificationType.vaccination:
        return Icons.vaccines_rounded;
      case NotificationType.medication:
        return Icons.medication_rounded;
      case NotificationType.system:
        return Icons.notifications_rounded;
    }
  }

  String _formatDate(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) return context.l10n.justNow;
    if (difference.inMinutes < 60) {
      return context.l10n.minutesAgo(difference.inMinutes);
    }
    if (difference.inHours < 24) {
      return context.l10n.hoursAgo(difference.inHours);
    }
    if (difference.inDays == 1) return context.l10n.yesterday;
    if (difference.inDays < 7) {
      return context.l10n.daysAgo(difference.inDays);
    }

    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRead = notification.isRead;

    final appointmentType = notification.data?['appointmentType'] as String?;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isRead
                ? context.colors.surface.withValues(alpha: 0.55)
                : theme.colorScheme.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isRead
                  ? theme.dividerColor.withValues(alpha: 0.08)
                  : theme.colorScheme.primary.withValues(alpha: 0.18),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: isRead
                      ? theme.dividerColor.withValues(alpha: 0.06)
                      : context.colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _getIcon(),
                  color: isRead
                      ? AppColors.tealLight.withValues(alpha: 0.4)
                      : AppColors.tealLight,
                  size: 23,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: isRead
                                  ? FontWeight.w500
                                  : FontWeight.w700,
                              color: isRead
                                  ? theme.textTheme.titleSmall?.color
                                        ?.withValues(alpha: 0.55)
                                  : null,
                            ),
                          ),
                        ),

                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: context.colors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      notification.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color?.withValues(
                          alpha: isRead ? 0.4 : 0.65,
                        ),
                        height: 1.4,
                      ),
                    ),

                    if (appointmentType != null) ...[
                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.primary.withValues(
                            alpha: isRead ? 0.04 : 0.08,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          appointmentType,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary.withValues(
                              alpha: isRead ? 0.45 : 1,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 8),

                    Text(
                      _formatDate(context, notification.createdAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(
                          alpha: isRead ? 0.3 : 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}