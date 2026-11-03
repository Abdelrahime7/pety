import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_serie.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class SeriesPickerSheet extends StatefulWidget {
  final List<VaccinationSerie> series;
  final VaccinationSerie? selectedSeries;

  const SeriesPickerSheet({
    super.key,
    required this.series,
    this.selectedSeries,
  });

  @override
  State<SeriesPickerSheet> createState() => _SeriesPickerSheetState();
}

class _SeriesPickerSheetState extends State<SeriesPickerSheet> {
  final _searchController = TextEditingController();

  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: context.colors.outlineVariant),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredSeries = widget.series
        .where(
          (serie) =>
              serie.vaccineName.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();

    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.selectVaccinationSeries,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.colors.onSurface,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              TextField(
                controller: _searchController,
                style: TextStyle(color: context.colors.onSurface),
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: context.l10n.searchVaccine,
                  hintStyle: TextStyle(color: context.colors.onSurfaceVariant),
                  prefixIcon: Icon(
                    Icons.search,
                    color: context.colors.onSurfaceVariant,
                  ),
                  filled: true,
                  fillColor: context.colors.surfaceContainerHighest,
                  border: _border(),
                  enabledBorder: _border(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: context.colors.primary),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: filteredSeries.isEmpty
                    ? Center(
                        child: Text(
                          context.l10n.noSeriesFound,
                          style: TextStyle(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: filteredSeries.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          color: context.colors.outlineVariant,
                        ),
                        itemBuilder: (context, index) {
                          final serie = filteredSeries[index];

                          final isSelected =
                              widget.selectedSeries?.id == serie.id;

                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            leading: Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: isSelected
                                  ? context.colors.primary
                                  : context.colors.onSurfaceVariant,
                            ),
                            title: Text(
                              serie.vaccineName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: context.colors.onSurface,
                              ),
                            ),
                            subtitle: Text(
                              context.l10n.dosesCount(serie.requiredDoses),
                              style: TextStyle(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop(serie);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}