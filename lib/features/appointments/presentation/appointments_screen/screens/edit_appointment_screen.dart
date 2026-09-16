import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/app_close_button.dart';
import 'package:pet_care/core/constant/widgets/app_save_button.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/core/constant/widgets/field_label.dart';
import 'package:pet_care/core/constant/widgets/outlined_button.dart';
import 'package:pet_care/core/constant/widgets/primary_button.dart';
import 'package:pet_care/features/appointments/domain/entity/appointment.dart';
import 'package:pet_care/features/appointments/presentation/riverpod/appointment_provider.dart';
import 'package:pet_care/features/appointments/presentation/appointments_screen/widgets/edit_appointment_widgets.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';

class EditAppointmentScreen extends ConsumerStatefulWidget {
  final Appointment appointment;

  const EditAppointmentScreen({super.key, required this.appointment});

  @override
  ConsumerState<EditAppointmentScreen> createState() => _EditAppointmentScreenState();
}

class _EditAppointmentScreenState extends ConsumerState<EditAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _selectedPetId;
  late DateTime _selectedDate;
  late final TextEditingController _dateController;
  late final TextEditingController _vetController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _selectedPetId = widget.appointment.petId;
    _selectedDate = widget.appointment.date;
    _dateController = TextEditingController(text: _formatDate(_selectedDate));
    _vetController = TextEditingController(text: widget.appointment.veterinarian);
    _notesController = TextEditingController(text: widget.appointment.notes);
  }

  @override
  void dispose() {
    _dateController.dispose();
    _vetController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) => DateFormat('MM / dd / yyyy , hh : mm a').format(date);

  Future<void> _pickDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (pickedDate == null || !mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
    );
    if (pickedTime == null || !mounted) return;

    setState(() {
      _selectedDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      _dateController.text = _formatDate(_selectedDate);
    });
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final updated = widget.appointment.copyWith(
      petId: _selectedPetId,
      date: _selectedDate,
      veterinarian: _vetController.text.trim(),
      notes: _notesController.text.trim(),
    );
    final result = await ref.read(appointmentProvider.notifier).updateAppointment(updated);

    if (!mounted) return;
    if (result is Success<void>) {
      context.pop(updated);
    } else if (result is Failure<void>) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final petsAsync = ref.watch(petNotifierProvider);
    final pets = petsAsync.valueOrNull ?? <Pet>[];
    final isSaving = ref.watch(appointmentProvider).isLoading;
    final selectedPet = ref.watch(petByIdProvider(_selectedPetId));

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppCloseButton(onPressed: context.pop),
                    Text('Edit Appointment', style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w800, color: AppColors.text)),
                    AppSaveButton(onPressed: isSaving ? null : _save, isLoading: isSaving, text: 'Save'),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                  children: [
                    EditingPetHeader(pet: selectedPet),
                    SizedBox(height: 18.h),
                    const FieldLabel(label: 'SELECT PET'),
                    EditPetSelector(pets: pets, selectedPetId: _selectedPetId, onSelected: (id) => setState(() => _selectedPetId = id)),
                    SizedBox(height: 18.h),
                    const FieldLabel(label: 'DATE & TIME'),
                    CustomeTextField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: _pickDateTime,
                      suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.icon),
                      validator: (value) => value == null || value.isEmpty ? 'Date is required' : null,
                    ),
                    SizedBox(height: 16.h),
                    const FieldLabel(label: 'VETERINARIAN'),
                    CustomeTextField(
                      controller: _vetController,
                      prefixIcon: const Icon(Icons.person_outline, size: 18, color: AppColors.icon),
                      validator: (value) => value == null || value.trim().isEmpty ? 'Veterinarian name is required' : null,
                    ),
                    SizedBox(height: 16.h),
                    const FieldLabel(label: 'NOTES'),
                    CustomeTextField(controller: _notesController, maxLines: 4),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(child: PrimaryOutlinedButton(text: 'Discard', textColor: AppColors.text, height: 48, radius: 12, onPressed: context.pop)),
                        SizedBox(width: 10.w),
                        Expanded(child: AppPrimaryButton(text: 'Save Changes', height: 48, borderRadius: 12, isLoading: isSaving, onPressed: isSaving ? null : _save)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
