import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';
import 'package:pet_care/features/pets/widgets/pet_card.dart';
import 'package:pet_care/features/pets/screens/add_pet_screen.dart';
import 'package:pet_care/core/constant/routers/routes_strings.dart';

class PetsListScreen extends ConsumerStatefulWidget {
  const PetsListScreen({super.key});

  @override
  ConsumerState<PetsListScreen> createState() => _PetsListScreenState();
}

class _PetsListScreenState extends ConsumerState<PetsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final petState = ref.watch(petProvider);

    final pets = petState.value ?? [];

    final filteredPets = pets.where((pet) {
      final query = _searchController.text.trim().toLowerCase();
      if (query.isEmpty) return true;
      return pet.name.toLowerCase().startsWith(query);
    }).toList();

    return Scaffold(
      backgroundColor: context.colors.surface,
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
                          color: context.colors.onSurface,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Manage all your furry friends in one place.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: context.colors.onSurfaceVariant,
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
                      decoration: BoxDecoration(
                        color: context.colors.primary,
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
                  border: Border.all(
                    color: context.colors.outlineVariant.withValues(alpha: 0.6),
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) =>
                      setState(() {}), // 🔥 THIS MAKES SEARCH WORK
                  decoration: InputDecoration(
                    hintText: 'Search by name or breed...',
                    hintStyle: TextStyle(
                      color: context.colors.onSurfaceVariant,
                      fontSize: 14.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: context.colors.onSurfaceVariant,
                    ),
                    filled: true,
                    fillColor: context.colors.surfaceContainer,
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
                          style: TextStyle(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredPets.length,
                      itemBuilder: (context, index) {
                        final pet = filteredPets[index];

                        return PetCard(
                          pet: pet,
                          onTap: () {
                            appRouter.push(petDetails, extra: pet);
                          },
                        );
                      },
                    );
                  },
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color: context.colors.primary,
                    ),
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
