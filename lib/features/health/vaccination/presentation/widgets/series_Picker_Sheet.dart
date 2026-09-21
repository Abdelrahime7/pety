
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_serie.dart';

class SeriesPickerSheet extends StatefulWidget {
  final List<VaccinationSerie> series;
  final VaccinationSerie? selectedSeries;

  const SeriesPickerSheet({
    required this.series,
    this.selectedSeries,
  });

  @override
  State<SeriesPickerSheet> createState() =>
      _SeriesPickerSheetState();
}

class _SeriesPickerSheetState
    extends State<SeriesPickerSheet> {
  final _searchController =
      TextEditingController();

  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSeries = widget.series
        .where(
          (serie) => serie.vaccineName
              .toLowerCase()
              .contains(_query.toLowerCase()),
        )
        .toList();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom:
              MediaQuery.of(context).viewInsets.bottom +
                  20,
        ),
        child: SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.75,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Select Vaccination Series',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search vaccine...',
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  enabledBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: filteredSeries.isEmpty
                    ? Center(
                        child: Text(
                          'No series found.',
                          style: TextStyle(
                            color:
                                Colors.grey.shade600,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount:
                            filteredSeries.length,
                        separatorBuilder:
                            (_, __) => Divider(
                          height: 1,
                          color:
                              Colors.grey.shade200,
                        ),
                        itemBuilder:
                            (context, index) {
                          final serie =
                              filteredSeries[index];

                          final isSelected =
                              widget.selectedSeries
                                      ?.id ==
                                  serie.id;

                          return ListTile(
                            contentPadding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            leading: Icon(
                              isSelected
                                  ? Icons
                                      .radio_button_checked
                                  : Icons
                                      .radio_button_unchecked,
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.grey.shade500,
                            ),
                            title: Text(
                              serie.vaccineName,
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              '${serie.requiredDoses} doses',
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pop(serie);
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
