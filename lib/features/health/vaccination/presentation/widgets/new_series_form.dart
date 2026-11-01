import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/features/pets/widgets/field_label.dart';

class NewSeriesForm extends StatelessWidget {
  final TextEditingController vaccineNameController;
  final TextEditingController requiredDosesController;

  const NewSeriesForm({
    super.key,
    required this.vaccineNameController,
    required this.requiredDosesController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(label: 'VACCINE NAME'),
        const SizedBox(height: 6),
        CustomeTextField(
          controller: vaccineNameController,
          hintText: 'e.g. Rabies',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Vaccine name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        const FieldLabel(label: 'NUMBER OF DOSES'),
        const SizedBox(height: 6),
        CustomeTextField(
          controller: requiredDosesController,
          hintText: 'e.g. 3',
          keyboardType: TextInputType.number,
          validator: (value) {
            final doses = int.tryParse(value?.trim() ?? '');
            if (doses == null || doses <= 0) {
              return 'Enter a valid number of doses';
            }
            return null;
          },
        ),
      ],
    );
  }
}
