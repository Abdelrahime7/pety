import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/features/authentication/presentation/helpers/helpers.dart';
import 'package:pet_care/features/pets/data/pet_data.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/features/pets/domain/enums/speciesOptions.dart';
import 'package:pet_care/features/pets/riverpod/pet_provider.dart';
import 'package:pet_care/features/pets/widgets/edit_drop_down.dart';

class PetEditScreen extends ConsumerStatefulWidget {
  final Pet pet;

  const PetEditScreen({
    super.key,
    required this.pet,
  });

  @override
  ConsumerState<PetEditScreen> createState() => _PetEditScreenState();
}

class _PetEditScreenState extends ConsumerState<PetEditScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _breedController;
  late final TextEditingController _weightController;
  late final TextEditingController _notesController;

  late String _species;
  late String _gender;

  File? _selectedImage;
  bool _isSaving = false;

  final List<String> _genderOptions = [
    'Male',
    'Female',
  ];
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.pet.name);
    _breedController = TextEditingController(text: widget.pet.breed);
    _weightController = TextEditingController(
      text: widget.pet.weight.toString(),
    );
    _notesController = TextEditingController(
      text: widget.pet.medicalNotes,
    );

    _species = widget.pet.species;
    _gender = widget.pet.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile == null) return;

    setState(() {
      _selectedImage = File(pickedFile.path);
    });
  }
  Future<void> _saveChanges() async {
    

     if (!_formKey.currentState!.validate()) {
    return;
  }
    final weight = double.tryParse(
  _weightController.text.trim(),
       );

    setState(() {
      _isSaving = true;
    });

    try {
      
 final PetRequest request = (
  id:widget.pet.id,
  name: _nameController.text.trim(),
  species: _species,
  breed: _breedController.text.trim(),
  gender: _gender,
  birthDate: null,
  weight: weight,
  medicalNotes: _notesController.text.trim(),
  photoUrl: null,
);
 
   final result= await ref.read(petProvider.notifier)
   .updatePet(request,image: _selectedImage);
     
    

      if (!mounted ) return;

 
     if (result is Success<void>) {
       showNotification(context,'Pet updated successfully');
         appRouter.pop(context);
      } else if (result is Failure<void>) {
        showNotification(context,result.message);

      }

    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: AppColors.text,
          ),
          onPressed: _isSaving
              ? null
              : () => Navigator.pop(context),
        ),

        title: Text(
          'Edit Pet',
          style: AppStyle.tileTitle,
        ),

        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Form(
          key:_formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPhotoSection(),
          
              const SizedBox(height: 28),
          
              _buildSectionTitle('Basic Information'),
          
              const SizedBox(height: 12),
          
              CustomeTextField(
                 validator: (value) {
                 if (value == null || value.trim().isEmpty) {
                    return 'Pet name is required';
                           }
                       return null;
                      },
                controller: _nameController,
                label: 'Pet Name',
                hintText: 'Enter pet name',
                suffixIcon: Icon(Icons.pets_rounded),
              ),
          
              const SizedBox(height: 14),
          
              buildDropdown(
                label: 'Species',
                value: _species,
                items: SpeciesOptions.values.map((e) => e.name).toList(),
                
                onChanged: (value) {
                  if (value == null) return;
          
                  setState(() {
                    _species = value;
                  });
                },
              ),
          
              const SizedBox(height: 14),
          
              CustomeTextField(
                controller: _breedController,
                 validator: (value){
                  if (value ==null ||value.trim().isEmpty )
                  {
                    return ' pet breed is required';
                  }
                    return null;
                 },
                label: 'Breed',
                hintText: 'Enter breed',
                suffixIcon: Icon( Icons.category_outlined),
              ),
          
              const SizedBox(height: 14),
          
              buildDropdown(
                label: 'Gender',
                value: _gender,
                items: _genderOptions,
                onChanged: (value) {
                  if (value == null) return;
          
                  setState(() {
                    _gender = value;
                  });
                },
              ),
          
              const SizedBox(height: 14),
          
              CustomeTextField(
                controller: _weightController,
                 validator: (value) {
                       if (value == null || value.trim().isEmpty) {
                                return 'Weight is required';
                            }
          
                             if (double.tryParse(value.trim()) == null) {
                               return 'Invalid weight';
                              }
          
                           return null;
                          },
                label: 'Weight',
                hintText: 'Enter weight',
                suffixIcon: Icon(Icons.monitor_weight_outlined),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                suffixText: 'kg',
              ),
          
              const SizedBox(height: 28),
          
              _buildSectionTitle('Notes'),
          
              const SizedBox(height: 12),
          
              _buildNotesField(),
          
              const SizedBox(height: 32),
          
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      )
                    : 
                            widget.pet.photoUrl.isNotEmpty
                        ? Image.network(
                            widget.pet.photoUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return const Icon(
                                Icons.pets_rounded,
                                size: 48,
                                color: AppColors.icon,
                              );
                            },
                          )
                        : const Icon(
                            Icons.pets_rounded,
                            size: 48,
                            color: AppColors.icon,
                          ),
              ),

              Positioned(
                right: 2,
                bottom: 2,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.surface,
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 18,
                      color: AppColors.surface,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            'Change photo',
            style: AppStyle.regular13,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: AppStyle.sectionHeader,
    );
  }
 

  Widget _buildNotesField() {
    return TextField(
      controller: _notesController,
      maxLines: 5,
      style: AppStyle.regular14.copyWith(
        color: AppColors.text,
      ),
      decoration: InputDecoration(
        hintText: 'Add notes about your pet...',
        hintStyle: AppStyle.regular14.copyWith(
          color: AppColors.textMuted,
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _isSaving ? null :_saveChanges,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: _isSaving
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.surface,
                ),
              )
            : Text(
                'Save Changes',
                style: AppStyle.buttonText.copyWith(
                  color: AppColors.surface,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}