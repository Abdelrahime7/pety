import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_serie.dart';
import 'package:pet_care/features/pets/widgets/field_label.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
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
        FieldLabel(label: context.l10n.selectSeries.toUpperCase()),
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
              '${context.l10n.noActiveSeries}\n${context.l10n.createNewSeriesInstead}',
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
        context.l10n.loadingSeries,
        style: TextStyle(color: colors.onSurfaceVariant),
      );
    }

    if (series == null) {
      return Text(
        context.l10n.selectASeries,
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
          context.l10n.dosesCompleted(
            series.completedDoses,
            series.requiredDoses,
          ),
          style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
        ),
        const SizedBox(height: 3),
        Text(
          context.l10n.nextDose(series.completedDoses + 1),
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