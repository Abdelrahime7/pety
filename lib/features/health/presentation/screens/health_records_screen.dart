import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/app_back_button.dart';
import 'package:pet_care/features/health/presentation/riverpod/health_provider.dart';
import 'package:pet_care/features/health/presentation/screens/add_record_screen.dart';
import 'package:pet_care/features/health/presentation/widgets/health_filter_list.dart';
import 'package:pet_care/features/health/presentation/widgets/health_pet_banner.dart';
import 'package:pet_care/features/health/presentation/widgets/health_records_list.dart';
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
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddHealthRecordScreen(
                    pet: pet,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
            color: AppColors.primary,
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),

              HealthPetBanner(
                pet: pet,
                recordsAsync: recordsAsync,
              ),

              SizedBox(height: 16.h),

              HealthFilterList(
                selectedFilter: selectedFilter,
                onFilterSelected: (filter) {
                  ref
                      .read(healthFilterProvider.notifier)
                      .state = filter;
                },
              ),

              SizedBox(height: 16.h),

              Expanded(
                child: HealthRecordsList(
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