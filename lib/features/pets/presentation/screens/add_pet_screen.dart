import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/app_close_button.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/core/constant/widgets/primary_button.dart';

import '../widgets/field_label.dart';
import '../widgets/gender_toggle.dart';
import '../widgets/photo_picker.dart';

class AddPetScreen extends ConsumerStatefulWidget {
  const AddPetScreen({super.key});

  @override
  ConsumerState<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends ConsumerState<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _weightController = TextEditingController();
  final _notesController = TextEditingController();
  final _dateController = TextEditingController();

  String _selectedSpecies = 'Dog';
  int _selectedGenderIndex = 0;
  bool _isNeutered = true;

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _weightController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    // Call Riverpod notifier here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: UnconstrainedBox(
          child: AppCloseButton(onPressed: () => Navigator.of(context).pop()),
        ),
        title: const Text(
          'Add New Pet',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _submit,
            child: Text(
              'Save',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: PetPhotoPicker(onTap: () {})),
                const SizedBox(height: 24),

                const FieldLabel(label: 'PET NAME'),
                CustomeTextField(
                  controller: _nameController,
                  hintText: 'e.g. Luna',
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FieldLabel(label: 'SPECIES'),
                          _buildSpeciesDropdown(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FieldLabel(label: 'BREED'),
                          CustomeTextField(
                            controller: _breedController,
                            hintText: 'e.g. Golden Retriever',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FieldLabel(label: 'GENDER'),
                          GenderToggle(
                            selectedIndex: _selectedGenderIndex,
                            onSelected: (index) =>
                                setState(() => _selectedGenderIndex = index),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FieldLabel(label: 'BIRTH DATE'),
                          _buildDateField(context),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FieldLabel(label: 'WEIGHT (LBS)'),
                          CustomeTextField(
                            controller: _weightController,
                            hintText: '0.0',
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FieldLabel(label: 'NEUTERED / SPAYED'),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Switch.adaptive(
                                value: _isNeutered,
                                activeColor: AppColors.primary,
                                onChanged: (val) =>
                                    setState(() => _isNeutered = val),
                              ),
                              Text(
                                _isNeutered ? 'Yes' : 'No',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                const FieldLabel(label: 'MEDICAL NOTES'),
                CustomeTextField(
                  controller: _notesController,
                  hintText: 'Allergies, chronic conditions, etc.',
                  maxLines: 4,
                ),
                const SizedBox(height: 28),

                AppPrimaryButton(
                  onPressed: _submit,
                  text: 'Add Pet',
                  height: 52,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpeciesDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedSpecies,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
      ),
      items: ['Dog', 'Cat', 'Bird', 'Other'].map((species) {
        return DropdownMenuItem(
          value: species,
          child: Text(species, style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: (val) => setState(() => _selectedSpecies = val!),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return CustomeTextField(
      controller: _dateController,
      readOnly: true,
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          _dateController.text =
              "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
        }
      },
      hintText: 'mm/dd/yyyy',
      suffixIcon: const Icon(
        Icons.calendar_today_outlined,
        size: 18,
        color: Color(0xFF7A869A),
      ),
    );
  }
}
