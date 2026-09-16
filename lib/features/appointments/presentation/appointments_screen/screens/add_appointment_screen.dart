import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/app_close_button.dart';
import 'package:pet_care/core/constant/widgets/app_save_button.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/core/constant/widgets/field_label.dart';
import 'package:pet_care/core/constant/widgets/primary_button.dart';
import 'package:pet_care/features/appointments/presentation/riverpod/appointment_provider.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';

class AddAppointmentScreen extends ConsumerStatefulWidget {
  const AddAppointmentScreen({super.key});

  @override
  ConsumerState<AddAppointmentScreen> createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends ConsumerState<AddAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedPetId;
  DateTime? _selectedDateTime;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _vetController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _vetController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate == null || !mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedDateTime != null
          ? TimeOfDay.fromDateTime(_selectedDateTime!)
          : TimeOfDay.now(),
    );

    if (pickedTime == null || !mounted) return;

    final fullDate = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      _selectedDateTime = fullDate;
      _dateController.text =
          "${fullDate.month.toString().padLeft(2, '0')} / ${fullDate.day.toString().padLeft(2, '0')} / ${fullDate.year} , ${pickedTime.format(context)}";
    });
  }

  Future<void> _submit() async {
    if (_selectedPetId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a pet')),
      );
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date and time')),
      );
      return;
    }

    final result = await ref.read(appointmentProvider.notifier).addAppointment(
          petId: _selectedPetId!,
          date: _selectedDateTime!,
          veterinarian: _vetController.text.trim(),
          notes: _notesController.text.trim(),
        );

    if (!mounted) return;

    if (result is Success<void>) {
      context.pop(true);
    } else if (result is Failure<void>) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointmentState = ref.watch(appointmentProvider);
    final petAsync = ref.watch(petNotifierProvider);

    final pets = petAsync.valueOrNull ?? [];

    if (_selectedPetId == null && pets.isNotEmpty) {
      _selectedPetId = pets.first.id;
    }

    final isSubmitting = appointmentState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Top Bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppCloseButton(onPressed: () => context.pop()),
                        Text(
                          'New Appointment',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        AppSaveButton(
                          onPressed: isSubmitting ? null : _submit,
                          isLoading: isSubmitting,
                        ),
                      ],
                    ),
                  ),

                  // Form Body
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      children: [
                        SizedBox(height: 16.h),
                        const FieldLabel(label: 'SELECT PET'),
                        SizedBox(height: 8.h),
                        _buildPetSelector(pets, petAsync.isLoading),

                        SizedBox(height: 20.h),
                        const FieldLabel(label: 'DATE'),
                        CustomeTextField(
                          controller: _dateController,
                          hintText: 'mm / dd / yyyy , --:-- --',
                          readOnly: true,
                          onTap: _pickDateTime,
                          suffixIcon: const Icon(
                            Icons.calendar_today_outlined,
                            size: 20,
                            color: AppColors.icon,
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Date is required' : null,
                        ),

                        SizedBox(height: 16.h),
                        const FieldLabel(label: 'VETERINARIAN'),
                        CustomeTextField(
                          controller: _vetController,
                          hintText: 'e.g. Dr. Sarah Mitchell',
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            size: 20,
                            color: AppColors.icon,
                          ),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                                  ? 'Veterinarian name is required'
                                  : null,
                        ),

                        SizedBox(height: 16.h),
                        const FieldLabel(label: 'NOTES'),
                        CustomeTextField(
                          controller: _notesController,
                          hintText: 'Anything the vet should know...',
                          maxLines: 4,
                        ),

                        SizedBox(height: 28.h),
                        AppPrimaryButton(
                          text: 'Schedule Appointment',
                          isLoading: isSubmitting,
                          onPressed: isSubmitting ? null : _submit,
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loading overlay
          if (isSubmitting) ...[
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.2)),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: AppColors.primary),
                    SizedBox(height: 16),
                    Text(
                      "Scheduling appointment…",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPetSelector(List<Pet> pets, bool isLoading) {
    if (isLoading && pets.isEmpty) {
      return SizedBox(
        height: 90.h,
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
        ),
      );
    }

    return SizedBox(
      height: 90.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: pets.length + 1,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          if (index == pets.length) {
            return _buildAddPetCard();
          }

          final pet = pets[index];
          final isSelected = pet.id == _selectedPetId;

          return GestureDetector(
            onTap: () => setState(() => _selectedPetId = pet.id),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 58.w,
                  height: 58.w,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: pet.photoUrl.isNotEmpty
                        ? Image.network(pet.photoUrl, fit: BoxFit.cover)
                        : Container(
                            color: const Color(0xFFF1F5F9),
                            child: const Icon(Icons.pets, color: AppColors.icon),
                          ),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  pet.name,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddPetCard() {
    return GestureDetector(
      onTap: () async {
        await context.push(addNewPet);
        ref.invalidate(petNotifierProvider);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58.w,
            height: 58.w,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.border,
                width: 1.2,
              ),
            ),
            child: const Icon(Icons.add, color: AppColors.icon, size: 22),
          ),
          SizedBox(height: 4.h),
          Text(
            'Add',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}