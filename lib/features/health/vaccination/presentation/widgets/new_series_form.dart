import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/features/pets/widgets/field_label.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
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
        FieldLabel(label: context.l10n.vaccineName.toUpperCase()),
        const SizedBox(height: 6),
        CustomeTextField(
          controller: vaccineNameController,
          hintText: context.l10n.hintVaccineName,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return context.l10n.vaccineNameRequired;
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        FieldLabel(label: context.l10n.numberOfDoses.toUpperCase()),
        const SizedBox(height: 6),
        CustomeTextField(
          controller: requiredDosesController,
          hintText: context.l10n.hintDoses,
          keyboardType: TextInputType.number,
          validator: (value) {
            final doses = int.tryParse(value?.trim() ?? '');
            if (doses == null || doses <= 0) {
              return context.l10n.enterValidDoses;
            }
            return null;
          },
        ),
      ],
    );
  }
}