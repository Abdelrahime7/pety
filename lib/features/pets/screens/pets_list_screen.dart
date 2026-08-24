import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';
import 'package:pet_care/features/pets/widgets/pet_card.dart';
import 'package:pet_care/features/pets/screens/add_pet_screen.dart'; // Ensure correct path

class PetsListScreen extends ConsumerWidget {
  const PetsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petState = ref.watch(petProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Pets',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Manage all your furry friends in one place.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),

                  // Add Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddPetScreen(),
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
                ],
              ),

              SizedBox(height: 32.h),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.border.withOpacity(0.6)),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by name or breed...',
                    hintStyle: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 14.sp,
                    ),
                    prefixIcon: const Icon(Icons.search, color: AppColors.icon),

                    // Makes the inside rounded
                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),

                    contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // List of Pets
              Expanded(
                child: petState.when(
                  data: (pets) {
                    if (pets.isEmpty) {
                      return Center(
                        child: Text(
                          "You haven't added any pets yet.",
                          style: TextStyle(color: AppColors.secondaryText),
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: pets.length,
                      itemBuilder: (context, index) {
                        return PetCard(
                          pet: pets[index],
                          onTap: () {
                            // Can navigate to pet details here later
                          },
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
