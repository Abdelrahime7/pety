import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';

import 'package:pet_care/features/health/domain/entity/health_item_entity.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class HealthPetBanner extends StatelessWidget {
  final Pet pet;
  final AsyncValue<List<HealthItem>> recordsAsync;

  const HealthPetBanner({
    super.key,
    required this.pet,
    required this.recordsAsync,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colors.outlineVariant),
        boxShadow: const [
          BoxShadow(
            color: Color(0x060F172A),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _PetThumbnail(url: pet.photoUrl),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.showingRecordsFor.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colors.onSurfaceVariant,
                    letterSpacing: context.tracking(0.6),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  pet.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: context.colors.onSurface,
                  ),
                ),
              ],
            ),
          ),

          recordsAsync.maybeWhen(
            data: (items) => _RecordCount(count: items.length),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _RecordCount extends StatelessWidget {
  final int count;

  const _RecordCount({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: context.colors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        context.l10n.recordsCount(count),
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: context.colors.primary,
        ),
      ),
    );
  }
}

class _PetThumbnail extends StatelessWidget {
  final String url;

  const _PetThumbnail({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.outlineVariant,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: url.isEmpty
          ? Center(
              child: Icon(
                Icons.pets,
                color: context.colors.onSurfaceVariant,
                size: 20,
              ),
            )
          : Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) {
                return Center(
                  child: Icon(
                    Icons.pets,
                    color: context.colors.onSurfaceVariant,
                    size: 20,
                  ),
                );
              },
            ),
    );
  }
}