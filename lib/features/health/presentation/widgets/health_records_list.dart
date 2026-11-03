import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pet_care/features/health/domain/entity/health_item_entity.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';
import 'package:pet_care/features/health/domain/enums/health_item.dart';
import 'package:pet_care/features/health/presentation/widgets/health_record_details_sheet.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/vaccination_details_sheet.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/vaccination_record_card.dart';
import 'package:pet_care/features/health/presentation/widgets/health_record_card.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_record.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
import 'package:pet_care/core/constant/l10n/display_labels.dart';
class HealthRecordsList extends StatelessWidget {
  final Pet pet;
  final AsyncValue<List<HealthItem>> recordsAsync;
  final String selectedFilter;
  final VoidCallback onRetry;

  const HealthRecordsList({
    super.key,
    required this.pet,
    required this.recordsAsync,
    required this.selectedFilter,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return recordsAsync.when(
      loading: () => Center(
        child: CircularProgressIndicator(color: context.colors.primary),
      ),

      error: (_, _) => HealthErrorState(onRetry: onRetry),

      data: (items) {
        final filteredItems = _filterItems(items);

        if (filteredItems.isEmpty) {
          return HealthEmptyState(
            petName: pet.name,
            selectedFilter: selectedFilter,
          );
        }

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: filteredItems.length,
          separatorBuilder: (_, _) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            return _buildItem(context, filteredItems[index]);
          },
        );
      },
    );
  }

  List<HealthItem> _filterItems(List<HealthItem> items) {
    if (selectedFilter == 'All') {
      return items;
    }

    final filter = selectedFilter.toLowerCase();

    return items.where((item) {
      if (item.type == HealthItemType.vaccination) {
        return filter == 'vaccination';
      }

      if (item is HealthRecord) {
        return item.recordType.name.toLowerCase() == filter;
      }

      return false;
    }).toList();
  }

  Widget _buildItem(BuildContext context, HealthItem item) {
    if (item is VaccinationRecord) {
      return VaccinationRecordCard(
        record: item,
        onTap: () {
          showVaccinationDetailsSheet(context, item);
        },
      );
    }

    if (item is HealthRecord) {
      return HealthRecordCard(
        record: item,
        onTap: () {
          showHealthRecordDetailsSheet(context, item);
        },
      );
    }

    return const SizedBox.shrink();
  }
}

class HealthEmptyState extends StatelessWidget {
  final String petName;
  final String selectedFilter;

  const HealthEmptyState({
    super.key,
    required this.petName,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    final isFiltered = selectedFilter != 'All';

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: context.colors.outlineVariant,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.health_and_safety_outlined,
                size: 34.sp,
                color: context.colors.onSurfaceVariant,
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              isFiltered
                  ? context.l10n.noFilteredRecords(
                      filterLabel(context.l10n, selectedFilter),
                    )
                  : context.l10n.noHealthRecordsYet,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: context.colors.onSurface,
              ),
            ),

            SizedBox(height: 6.h),

            Text(
              isFiltered
                  ? context.l10n.noFilteredRecordsForPet(
                      filterLabel(context.l10n, selectedFilter),
                      petName,
                    )
                  : context.l10n.healthRecordsForPetWillAppear(petName),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: context.colors.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthErrorState extends StatelessWidget {
  final VoidCallback onRetry;

  const HealthErrorState({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: context.colors.error.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.error_outline,
                size: 34.sp,
                color: context.colors.error,
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              context.l10n.somethingWentWrong,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: context.colors.onSurface,
              ),
            ),

            SizedBox(height: 6.h),

            Text(
              context.l10n.couldNotLoadRecords,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: context.colors.onSurfaceVariant,
              ),
            ),

            SizedBox(height: 16.h),

            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                context.l10n.tryAgain,
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}