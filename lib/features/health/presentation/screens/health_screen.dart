import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/health/presentation/riverpod/health_provider.dart';
import 'package:pet_care/features/health/presentation/widgets/health_pet_card.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class HealthScreen extends ConsumerStatefulWidget {
  const HealthScreen({super.key});

  @override
  ConsumerState<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends ConsumerState<HealthScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final healthState = ref.watch(healthProvider);
    final pets = healthState.pets.where((pet) {
      final query = _query.trim().toLowerCase();
      return query.isEmpty || pet.name.toLowerCase().contains(query) || pet.breed.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 22.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Health', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w900, color: AppColors.text)),
                SizedBox(height: 6.h),
                Text('Select a pet to view their records.', style: TextStyle(fontSize: 12.sp, color: AppColors.secondaryText)),
              ]),
              Container(width: 40.w, height: 40.w, decoration: const BoxDecoration(color: Color(0xFFE6FFFA), shape: BoxShape.circle), child: const Icon(Icons.favorite_outline, color: AppColors.primary, size: 20)),
            ]),
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r), border: Border.all(color: AppColors.border.withValues(alpha: 0.6))),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: 'Search by name or breed...',
                  hintStyle: TextStyle(color: AppColors.secondaryText, fontSize: 14.sp),
                  prefixIcon: const Icon(Icons.search, color: AppColors.icon),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: healthState.isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                  : healthState.error != null
                      ? Center(child: Text(healthState.error!))
                      : pets.isEmpty
                          ? Center(child: Text('No pets found.', style: TextStyle(color: AppColors.secondaryText)))
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: pets.length,
                              itemBuilder: (_, index) => HealthPetCard(
                                pet: pets[index],
                                records: healthState.recordsByPet[pets[index].id] ?? const [],
                                onTap: () => ref.read(healthProvider.notifier).selectPet(pets[index]),
                              ),
                            ),
            ),
          ]),
        ),
      ),
    );
  }
}
