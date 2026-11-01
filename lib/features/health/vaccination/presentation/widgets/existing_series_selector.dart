import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_serie.dart';
import 'package:pet_care/features/pets/widgets/field_label.dart';

class ExistingSeriesSelector extends StatelessWidget {
  final VaccinationSerie? selectedSeries;
  final bool isLoading;
  final bool hasNoActiveSeries;
  final VoidCallback onTap;

  const ExistingSeriesSelector({
    super.key,
    required this.selectedSeries,
    required this.isLoading,
    required this.hasNoActiveSeries,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(label: 'SELECT SERIES'),
        const SizedBox(height: 6),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: isLoading ? null : onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest,
              border: Border.all(color: colors.outlineVariant),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.vaccines_outlined,
                  size: 20,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(width: 10),
                Expanded(child: _buildLabel(context)),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
        if (hasNoActiveSeries)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'No active vaccination series found. '
              'Create a new series instead.',
              style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
            ),
          ),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    final colors = context.colors;
    final series = selectedSeries;

    if (isLoading) {
      return Text(
        'Loading series...',
        style: TextStyle(color: colors.onSurfaceVariant),
      );
    }

    if (series == null) {
      return Text(
        'Select a series',
        style: TextStyle(color: colors.onSurfaceVariant),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          series.vaccineName,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colors.onSurface,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          '${series.completedDoses}/${series.requiredDoses} doses completed',
          style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
        ),
        const SizedBox(height: 3),
        Text(
          'Next dose: ${series.completedDoses + 1}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colors.primary,
          ),
        ),
      ],
    );
  }
}
