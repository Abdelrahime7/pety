import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/app_close_button.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/core/constant/widgets/primary_button.dart';

import 'package:pet_care/features/health/vaccination/domain/entity/vaccination1.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/vaccination_providers.dart';
import 'package:pet_care/features/pets/widgets/field_label.dart';
import 'package:uuid/uuid.dart';


class AddVaccinationScreen extends ConsumerStatefulWidget {
  final String petId;
  const AddVaccinationScreen({
    super.key,
    required this.petId,
  });

  @override
  ConsumerState<AddVaccinationScreen> createState() =>
      _AddVaccinationScreenState();
}

class _AddVaccinationScreenState
    extends ConsumerState<AddVaccinationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _vaccineNameController = TextEditingController();
  final _vaccinationDateController = TextEditingController();
  final _nextDueDateController = TextEditingController();
  final _notesController = TextEditingController();
  final _nextVaccineController =TextEditingController();

  DateTime? _vaccinationDate;
  DateTime? _nextDueDate;

  @override
  void dispose() {
    _vaccineNameController.dispose();
    _vaccinationDateController.dispose();
    _nextDueDateController.dispose();
    _notesController.dispose();
    _nextVaccineController.dispose();

    super.dispose();
  }

  Future<void> _selectVaccinationDate() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: _vaccinationDate ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        _vaccinationDate = picked;

        _vaccinationDateController.text =
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.year}';

        // If next due date was before the new vaccination date,
        // clear it.
        if (_nextDueDate != null &&
            _nextDueDate!.isBefore(picked)) {
          _nextDueDate = null;
          _nextDueDateController.clear();
        }
      });
    }
  }

  Future<void> _selectNextDueDate() async {
    final firstDate = _vaccinationDate ?? DateTime.now();

    final initialDate =
        _nextDueDate ??
        _vaccinationDate?.add(const Duration(days: 365)) ??
        DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(firstDate)
          ? firstDate
          : initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _nextDueDate = picked;

        _nextDueDateController.text =
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }
  
Future<void> _addVaccination() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  if (_vaccinationDate == null) {
    _showError('Vaccination date is required.');
    return;
  }

  final vaccinationId = const Uuid().v4();

  final vaccination = Vaccination(
    id: vaccinationId,
    petId: widget.petId,
    vaccineName: _vaccineNameController.text.trim(),
    vaccinationDate: _vaccinationDate!,
    nextDueDate: _nextDueDate,
    notes: _notesController.text.trim().isEmpty
        ? null
        : _notesController.text.trim(),
    nextVaccineName: _nextVaccineController.text.trim().isEmpty
        ? null
        : _nextVaccineController.text.trim(),
  );

  final notifier =
      ref.read(vaccinationProvider(widget.petId).notifier);

  final result = await notifier.addVaccination(vaccination);

  if (!mounted) return;

  if (result is Success<void>) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Vaccination added successfully'),
      ),
    );

    Navigator.of(context).pop();
  } else if (result is Failure<void>) {
    _showError(result.message);
  }
}
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vaccinationState =
        ref.watch(vaccinationProvider(widget.petId));

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: UnconstrainedBox(
          child: AppCloseButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        title: const Text(
          'Add Vaccination',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),

        centerTitle: true,

        actions: [
          TextButton(
            onPressed:
                vaccinationState.isLoading ? null : _addVaccination,
            child: Text(
              'Save',
              style: TextStyle(
                color: vaccinationState.isLoading
                    ? Colors.grey
                    : AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Form(
                key: _formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldLabel(
                      label: 'VACCINATION DETAILS',
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Keep track of your pet’s vaccinations and upcoming doses.',
                      style: TextStyle(
                        color: Color(0xFF7A869A),
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // VACCINE NAME
                    const FieldLabel(
                      label: 'VACCINE NAME',
                    ),

                    CustomeTextField(
                      controller: _vaccineNameController,
                      hintText: 'e.g. Rabies',
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Vaccine name is required';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    // VACCINATION DATE
                    const FieldLabel(
                      label: 'VACCINATION DATE',
                    ),

                    CustomeTextField(
                      controller: _vaccinationDateController,
                      hintText: 'mm/dd/yyyy',
                      readOnly: true,
                      onTap: _selectVaccinationDate,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vaccination date is required';
                        }

                        return null;
                      },
                      suffixIcon: const Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: Color(0xFF7A869A),
                      ),
                    ),

                    const SizedBox(height: 12),
                      const FieldLabel(
                      label: 'NEXT VACCINE NAME',
                    ),

                    CustomeTextField(
                      controller: _nextVaccineController,
                      hintText: 'e.g. Rabies',
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Vaccine name is required';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 12),


                    // NEXT DUE DATE
                    const FieldLabel(
                      label: 'NEXT DUE DATE',
                    ),

                    CustomeTextField(
                      controller: _nextDueDateController,
                      hintText: 'mm/dd/yyyy',
                      readOnly: true,
                      onTap: _selectNextDueDate,
                      suffixIcon: const Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: Color(0xFF7A869A),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // NOTES
                    const FieldLabel(
                      label: 'NOTES',
                    ),

                    CustomeTextField(
                      controller: _notesController,
                      hintText:
                          'Optional notes about this vaccination...',
                      maxLines: 4,
                    ),

                    const SizedBox(height: 28),

                    // ADD BUTTON
                    AppPrimaryButton(
                      onPressed: vaccinationState.isLoading
                          ? null
                          : _addVaccination,
                      text: 'Add Vaccination',
                      height: 52,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // LOADING OVERLAY
          if (vaccinationState.isLoading) ...[
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),

            Center(
              child: Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),

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
                    CircularProgressIndicator(
                      color: AppColors.primary,
                    ),

                    SizedBox(height: 16),

                    Text(
                      'Saving vaccination…',
                      style: TextStyle(
                        fontSize: 16,
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
}