import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/app_close_button.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/core/constant/widgets/primary_button.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';

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
  File? _selectedImage;

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

    final notifier = ref.read(petProvider.notifier);
    final userId = FirebaseAuth.instance.currentUser?.uid;

    // Convert date
    DateTime? birthDate;
    if (_dateController.text.isNotEmpty) {
      final parts = _dateController.text.split('/');
      birthDate = DateTime(
        int.parse(parts[2]),
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
    }

    final pet = Pet(
      id: '', // Firebase will generate ID
      ownerId: userId.toString(),
      name: _nameController.text.trim(),
      species: _selectedSpecies,
      breed: _breedController.text.trim(),
      gender: _selectedGenderIndex == 0 ? 'Male' : 'Female',
      birthDate: birthDate ?? DateTime.now(),
      weight: double.tryParse(_weightController.text.trim()) ?? 0.0,
      medicalNotes: _notesController.text.trim(),
      photoUrl: "",
    );

    notifier.addPet(pet, image: _selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    final petState = ref.watch(petProvider);

    // Listen for success → navigate back
    ref.listen(petProvider, (previous, next) {
      if (previous?.isLoading == true &&
          next.isLoading == false &&
          !next.hasError) {
        Navigator.of(context).pop();
      }
    });

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
            onPressed: petState.isLoading ? null : _submit,
            child: Text(
              'Save',
              style: TextStyle(
                color: petState.isLoading ? Colors.grey : AppColors.primary,
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: PetPhotoPicker(
                        imageFile: _selectedImage,
                        onImageSelected: (file) {
                          setState(() {
                            _selectedImage = file;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    const FieldLabel(label: 'PET NAME'),
                    CustomeTextField(
                      controller: _nameController,
                      hintText: 'e.g. Luna',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Pet name is required';
                        }
                        return null;
                      },
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
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Breed is required';
                                  }
                                  return null;
                                },
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
                                onSelected: (index) => setState(
                                  () => _selectedGenderIndex = index,
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
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  final numValue = double.tryParse(value ?? '');
                                  if (numValue == null || numValue <= 0) {
                                    return 'Enter a valid weight';
                                  }
                                  return null;
                                },
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
                      onPressed: petState.isLoading ? null : _submit,
                      text: 'Add Pet',
                      height: 52,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ⭐ GREY OUT OVERLAY + LOADING CARD
          if (petState.isLoading) ...[
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.3)),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: AppColors.primary),
                    const SizedBox(height: 16),
                    const Text(
                      "Saving your pet…",
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Birth date is required';
        }
        return null;
      },
      suffixIcon: const Icon(
        Icons.calendar_today_outlined,
        size: 18,
        color: Color(0xFF7A869A),
      ),
    );
  }
}
