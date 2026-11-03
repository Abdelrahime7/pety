import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/routers/routes_strings.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/core/constant/widgets/app_close_button.dart';
import 'package:pet_care/core/constant/widgets/app_save_button.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/core/constant/widgets/field_label.dart';
import 'package:pet_care/core/constant/widgets/primary_button.dart';

import 'package:pet_care/features/appointments/domain/enums/appointment_types.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/appointment_type_selector.dart';
import 'package:pet_care/features/appointments/presentation/riverpod/appointment_provider.dart';

import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class AddAppointmentScreen extends ConsumerStatefulWidget {
  const AddAppointmentScreen({super.key});

  @override
  ConsumerState<AddAppointmentScreen> createState() =>
      _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends ConsumerState<AddAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedPetId;

  AppointmentType _selectedType = AppointmentType.other;

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
          "${fullDate.month.toString().padLeft(2, '0')} / "
          "${fullDate.day.toString().padLeft(2, '0')} / "
          "${fullDate.year} , "
          "${pickedTime.format(context)}";
    });
  }

  Future<void> _submit() async {
    if (_selectedPetId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.pleaseSelectPet)));
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (_selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.pleaseSelectDateTime)),
      );
      return;
    }

    final result = await ref
        .read(appointmentProvider.notifier)
        .addAppointment(
          petId: _selectedPetId!,
          date: _selectedDateTime!,
          veterinarian: _vetController.text.trim(),
          notes: _notesController.text.trim(),
          type: _selectedType,
        );

    if (!mounted) return;

    if (result is Success<void>) {
      context.pop(true);
    } else if (result is Failure<void>) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.message)));
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
      backgroundColor: context.colors.surface,
      body: Stack(
        children: [
          SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Top Bar
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppCloseButton(onPressed: () => context.pop()),
                        Text(
                          context.l10n.newAppointment,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: context.colors.onSurface,
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

                        // SELECT PET
                        FieldLabel(label: context.l10n.selectPet.toUpperCase()),
                        SizedBox(height: 8.h),

                        _buildPetSelector(pets, petAsync.isLoading),

                        SizedBox(height: 20.h),

                        // APPOINTMENT TYPE
                        FieldLabel(label: context.l10n.type.toUpperCase()),
                        SizedBox(height: 8.h),

                        buildAppointmentTypeSelector(
                          context,
                          selectedType: _selectedType,
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value!;
                            });
                          },
                        ),

                        SizedBox(height: 20.h),

                        // DATE
                        FieldLabel(label: context.l10n.date.toUpperCase()),

                        CustomeTextField(
                          controller: _dateController,
                          hintText: context.l10n.hintDateTime,
                          readOnly: true,
                          onTap: _pickDateTime,
                          suffixIcon: Icon(
                            Icons.calendar_today_outlined,
                            size: 20,
                            color: context.colors.onSurfaceVariant,
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? context.l10n.dateRequired
                              : null,
                        ),

                        SizedBox(height: 16.h),

                        // VETERINARIAN
                        FieldLabel(label: context.l10n.veterinarian.toUpperCase()),

                        CustomeTextField(
                          controller: _vetController,
                          hintText: context.l10n.hintVetName,
                          prefixIcon: Icon(
                            Icons.person_outline,
                            size: 20,
                            color: context.colors.onSurfaceVariant,
                          ),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? context.l10n.vetNameRequired
                              : null,
                        ),

                        SizedBox(height: 16.h),

                        // NOTES
                        FieldLabel(label: context.l10n.notes.toUpperCase()),

                        CustomeTextField(
                          controller: _notesController,
                          hintText: context.l10n.hintAnythingVetShouldKnow,
                          maxLines: 4,
                        ),

                        SizedBox(height: 28.h),

                        AppPrimaryButton(
                          text: context.l10n.scheduleAppointment,
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
              child: Container(color: Colors.black.withValues(alpha: 0.2)),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: context.colors.primary),
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.schedulingAppointment,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: context.colors.onSurface,
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
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: context.colors.primary,
          ),
        ),
      );
    }

    return SizedBox(
      height: 90.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: pets.length + 1,
        separatorBuilder: (_, _) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          if (index == pets.length) {
            return _buildAddPetCard();
          }

          final pet = pets[index];
          final isSelected = pet.id == _selectedPetId;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedPetId = pet.id;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 58.w,
                  height: 58.w,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isSelected
                          ? context.colors.primary
                          : context.colors.outlineVariant,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: pet.photoUrl.isNotEmpty
                        ? Image.network(pet.photoUrl, fit: BoxFit.cover)
                        : Container(
                            color: context.colors.outlineVariant,
                            child: Icon(
                              Icons.pets,
                              color: context.colors.onSurfaceVariant,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  pet.name,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected
                        ? context.colors.primary
                        : context.colors.onSurfaceVariant,
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
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: context.colors.outlineVariant,
                width: 1.2,
              ),
            ),
            child: Icon(
              Icons.add,
              color: context.colors.onSurfaceVariant,
              size: 22,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            context.l10n.add,
            style: TextStyle(
              fontSize: 12.sp,
              color: context.colors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}