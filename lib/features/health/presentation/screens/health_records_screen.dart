import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/app_back_button.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';
import 'package:pet_care/features/health/domain/enums/health_record_type.dart';
import 'package:pet_care/features/health/presentation/riverpod/health_provider.dart';
import 'package:pet_care/features/health/presentation/screens/add_record_screen.dart';
import 'package:pet_care/features/health/presentation/widgets/health_record_card.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class HealthRecordsScreen extends ConsumerWidget {
  final Pet pet;

  const HealthRecordsScreen({
    super.key,
    required this.pet,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(
      healthRecordsProvider(pet.id),
    );

    final selectedFilter = ref.watch(
      healthFilterProvider,
    );

    return Scaffold(
      backgroundColor: AppColors.background,

      // ─────────────────────────────────────────────
      // APP BAR
      // ─────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: AppBackButton(),
        ),

        title: Text(
          'Health Records',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),

        centerTitle: true,

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddHealthRecordScreen(
                      pet: pet,
                    ),
                  ),
                );
              },
              child: Container(
                width: 42.w,
                height: 42.w,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x332DD4BF),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),

      // ─────────────────────────────────────────────
      // BODY
      // ─────────────────────────────────────────────
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),

              // ─────────────────────────────────────
              // PET BANNER
              // ─────────────────────────────────────
              _PetBanner(
                pet: pet,
                recordsAsync: recordsAsync,
              ),

              SizedBox(height: 16.h),

              // ─────────────────────────────────────
              // FILTERS
              // ─────────────────────────────────────
              _FilterList(
                selectedFilter: selectedFilter,
                onFilterSelected: (filter) {
                  ref.read(healthFilterProvider.notifier).state = filter;
                },
              ),

              SizedBox(height: 16.h),

              // ─────────────────────────────────────
              // RECORDS
              // ─────────────────────────────────────
              Expanded(
                child: _RecordsList(
                  pet: pet,
                  recordsAsync: recordsAsync,
                  selectedFilter: selectedFilter,
                  onRetry: () {
                    ref
                        .read(
                          healthRecordsProvider(pet.id).notifier,
                        )
                        .refreshRecords();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// PET BANNER
// ═══════════════════════════════════════════════════

class _PetBanner extends StatelessWidget {
  final Pet pet;
  final AsyncValue<List<HealthRecord>> recordsAsync;

  const _PetBanner({
    required this.pet,
    required this.recordsAsync,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFF1F5F9),
        ),
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
          _PetThumbnail(
            url: pet.photoUrl,
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SHOWING RECORDS FOR',
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF94A3B8),
                    letterSpacing: 0.6,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  pet.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),

          recordsAsync.maybeWhen(
            data: (records) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE6FFFA),
                borderRadius: BorderRadius.circular(999.r),
              ),
              child: Text(
                '${records.length} records',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0D9488),
                ),
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// FILTER LIST
// ═══════════════════════════════════════════════════

class _FilterList extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  const _FilterList({
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  static const List<String> filters = [
    'All',
    'Vaccination',
    'Checkup',
    'Medication',
    'Allergy',
    'Surgery',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((filter) {
          final isSelected =
              filter.toLowerCase() == selectedFilter.toLowerCase();

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () => onFilterSelected(filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : Colors.white,
                  borderRadius: BorderRadius.circular(999.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: isSelected
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF64748B),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// RECORDS LIST
// ═══════════════════════════════════════════════════

class _RecordsList extends ConsumerWidget {
  final Pet pet;
  final AsyncValue<List<HealthRecord>> recordsAsync;
  final String selectedFilter;
  final VoidCallback onRetry;

  const _RecordsList({
    required this.pet,
    required this.recordsAsync,
    required this.selectedFilter,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return recordsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),

      error: (error, _) => _ErrorState(
        onRetry: onRetry,
      ),

      data: (records) {
        final filteredRecords = selectedFilter == 'All'
            ? records
            : records.where(
                (record) =>
                    record.type.name.toLowerCase() ==
                    selectedFilter.toLowerCase(),
              ).toList();

        if (filteredRecords.isEmpty) {
          return _EmptyState(
            petName: pet.name,
            selectedFilter: selectedFilter,
          );
        }

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: filteredRecords.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final record = filteredRecords[index];

            return HealthRecordCard(
              record: record,
              onTap: () {
                _showRecordDetails(
                  context,
                  record,
                );
              },
            );
          },
        );
      },
    );
  }

  void _showRecordDetails(
    BuildContext context,
    HealthRecord record,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _RecordDetailsSheet(
        record: record,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// EMPTY STATE
// ═══════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  final String petName;
  final String selectedFilter;

  const _EmptyState({
    required this.petName,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.folder_open_outlined,
              color: Color(0xFF94A3B8),
              size: 28,
            ),
          ),

          SizedBox(height: 12.h),

          Text(
            'No records found',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),

          SizedBox(height: 4.h),

          Text(
            selectedFilter == 'All'
                ? 'No health records on file for $petName.'
                : 'No $selectedFilter records on file.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// ERROR STATE
// ═══════════════════════════════════════════════════

class _ErrorState extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorState({
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 42.sp,
            color: AppColors.error,
          ),

          SizedBox(height: 12.h),

          Text(
            'Unable to load health records.',
            style: TextStyle(
              color: AppColors.error,
              fontSize: 14.sp,
            ),
          ),

          SizedBox(height: 8.h),

          TextButton(
            onPressed: onRetry,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// RECORD DETAILS
// ═══════════════════════════════════════════════════

class _RecordDetailsSheet extends StatelessWidget {
  final HealthRecord record;

  const _RecordDetailsSheet({
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(999.r),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: record.type.backgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  record.type.icon,
                  color: record.type.color,
                  size: 22.sp,
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),

                    SizedBox(height: 3.h),

                    Text(
                      '${record.type.displayName} • '
                      '${DateFormat('MMMM dd, yyyy').format(record.date)}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (record.notes.isNotEmpty) ...[
            SizedBox(height: 16.h),

            Text(
              'Veterinary Notes & Observations',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),

            SizedBox(height: 6.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFF1F5F9),
                ),
              ),
              child: Text(
                record.notes,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF475569),
                  height: 1.45,
                ),
              ),
            ),
          ],

          SizedBox(height: 20.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 14.h,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// PET THUMBNAIL
// ═══════════════════════════════════════════════════

class _PetThumbnail extends StatelessWidget {
  final String url;

  const _PetThumbnail({
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: url.isEmpty
          ? const Center(
              child: Icon(
                Icons.pets,
                color: AppColors.icon,
                size: 20,
              ),
            )
          : Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return const Center(
                  child: Icon(
                    Icons.pets,
                    color: AppColors.icon,
                    size: 20,
                  ),
                );
              },
            ),
    );
  }
}