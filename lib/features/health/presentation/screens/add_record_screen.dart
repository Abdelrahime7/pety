import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/app_back_button.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';
import 'package:pet_care/features/health/domain/enums/health_record_type.dart';
import 'package:pet_care/features/health/presentation/riverpod/health_provider.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

import '../widgets/health_record_pet_header.dart';
import '../widgets/health_record_selector_field.dart';
import '../widgets/health_record_type_sheet.dart';

class AddHealthRecordScreen extends ConsumerStatefulWidget {
  final Pet pet;

  const AddHealthRecordScreen({
    super.key,
    required this.pet,
  });

  @override
  ConsumerState<AddHealthRecordScreen> createState() =>
      _AddHealthRecordScreenState();
}

class _AddHealthRecordScreenState
    extends ConsumerState<AddHealthRecordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _veterinarianController = TextEditingController();
  final _notesController = TextEditingController();

  HealthRecordType _selectedType = HealthRecordType.checkup;
  DateTime _selectedDate = DateTime.now();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _veterinarianController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selectedDate == null) return;

    setState(() {
      _selectedDate = selectedDate;
    });
  }

  Future<void> _selectType() async {
    final selectedType = await showModalBottomSheet<HealthRecordType>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => HealthRecordTypeSheet(
        selectedType: _selectedType,
      ),
    );

    if (selectedType == null) return;

    setState(() {
      _selectedType = selectedType;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final result = await ref
        .read(healthRecordsProvider(widget.pet.id).notifier)
        .createRecord(
          HealthRecord(
            recordId: '',
            petId: widget.pet.id,
            recordType: _selectedType,
            title: _titleController.text.trim(),
            date: _selectedDate,
            notes: _notesController.text.trim(),
            veterinarian: _veterinarianController.text.trim(),
          ),
        );

    if (!mounted) return;

    if (result is Success<void>) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Health record added successfully'),
        ),
      );

      Navigator.of(context).pop();
      return;
    }

    if (result is Failure<void>) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
        ),
      );
    }

    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: AppBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add Health Record',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            20.w,
            16.h,
            20.w,
            120.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HealthRecordPetHeader(
                pet: widget.pet,
              ),

              SizedBox(height: 28.h),

              Text(
                'Record Information',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),

              SizedBox(height: 20.h),

              // Record Type
              Text(
                'Record Type *',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
              ),

              SizedBox(height: 8.h),

              HealthRecordSelectorField(
                icon: _selectedType.icon,
                iconColor: _selectedType.color,
                iconBackground: _selectedType.backgroundColor,
                title: _selectedType.displayName,
                subtitle: 'Select the type of health record',
                onTap: _selectType,
              ),

              SizedBox(height: 20.h),

              // Title
              CustomeTextField(
                controller: _titleController,
                label: 'Title *',
                hintText: 'e.g. Annual checkup',
                prefixIcon: Icon(
                  Icons.title_rounded,
                  size: 21.sp,
                  color: AppColors.textSecondary,
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }

                  return null;
                },
              ),

              SizedBox(height: 20.h),

              // Date
              Text(
                'Date *',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
              ),

              SizedBox(height: 8.h),

              HealthRecordSelectorField(
                icon: Icons.calendar_today_rounded,
                iconColor: AppColors.primary,
                iconBackground: AppColors.primary.withValues(
                  alpha: 0.1,
                ),
                title: DateFormat(
                  'MMM dd, yyyy',
                ).format(_selectedDate),
                subtitle: 'When did this happen?',
                onTap: _selectDate,
              ),

              SizedBox(height: 20.h),

              // Veterinarian
              CustomeTextField(
                controller: _veterinarianController,
                label: 'Veterinarian',
                hintText: 'e.g. Dr. Sarah Smith',
                prefixIcon: Icon(
                  Icons.medical_services_rounded,
                  size: 21.sp,
                  color: AppColors.textSecondary,
                ),
                textInputAction: TextInputAction.next,
              ),

              SizedBox(height: 20.h),

              // Notes
              CustomeTextField(
                controller: _notesController,
                label: 'Notes',
                hintText: 'Add any additional information...',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(
                    left: 14.w,
                    right: 8.w,
                  ),
                  child: Icon(
                    Icons.notes_rounded,
                    size: 21.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                maxLines: 5,
              ),

              SizedBox(height: 20.h),

              // Information
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(
                    alpha: 0.07,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 20.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Keep your pet\'s health records up to date '
                        'to make it easier to track their health history.',
                        style: TextStyle(
                          fontSize: 13.sp,
                          height: 1.45,
                          color: AppColors.textSecondary,
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

      // Submit button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20.w,
            12.h,
            20.w,
            16.h,
          ),
          child: SizedBox(
            height: 54.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                disabledBackgroundColor:
                    AppColors.primary.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: _isSubmitting
                  ? SizedBox(
                      width: 22.w,
                      height: 22.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Add Health Record',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}