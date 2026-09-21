
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/widgets/app_close_button.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/core/constant/widgets/primary_button.dart';
import 'package:pet_care/features/authentication/presentation/helpers/helpers.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/add_vaccination_request.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_serie.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/vaccination_providers.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/series_Picker_Sheet.dart';
import 'package:pet_care/features/pets/widgets/field_label.dart';

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

  final _requiredDosesController =
      TextEditingController(text: '3');

  final _vaccinationDateController = TextEditingController();

  final _notesController = TextEditingController();

  DateTime? _vaccinationDate;

  bool _isNewSeries = true;

  VaccinationSerie? _selectedSeries;

  @override
  void dispose() {
    _vaccineNameController.dispose();
    _requiredDosesController.dispose();
    _vaccinationDateController.dispose();
    _notesController.dispose();

    super.dispose();
  }

  // ============================================================
  // DATE PICKER
  // ============================================================

  Future<void> _selectVaccinationDate() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: _vaccinationDate ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    );

    if (picked == null) {
      return;
    }

    setState(() {
      _vaccinationDate = picked;

      _vaccinationDateController.text =
          '${picked.month.toString().padLeft(2, '0')}/'
          '${picked.day.toString().padLeft(2, '0')}/'
          '${picked.year}';
    });
  }

  // ============================================================
  // SELECT EXISTING SERIES
  // ============================================================

  Future<void> _selectExistingSeries() async {
    final seriesState =
        ref.read(vaccinationSerieProvider(widget.petId));

    final allSeries = seriesState.value ?? [];

    // Only active series should be selectable.
    final activeSeries = allSeries
        .where(
          (serie) =>
              serie.completedDoses < serie.requiredDoses,
        )
        .toList();

    if (activeSeries.isEmpty) {
      showNotification(
        context,
        'No active vaccination series found.',
        success: false,
      );
      return;
    }

    final selected =
        await showModalBottomSheet<VaccinationSerie>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SeriesPickerSheet(
          series: activeSeries,
          selectedSeries: _selectedSeries,
        );
      },
    );

    if (selected == null) {
      return;
    }

    setState(() {
      _selectedSeries = selected;
    });
  }

  // ============================================================
  // ADD VACCINATION
  // ============================================================
Future<void> _addVaccination() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  if (_vaccinationDate == null) {
    showNotification(
      context,
      'Vaccination date is required.',
      success: false,
    );
    return;
  }

  int? requiredDoses;

  if (_isNewSeries) {
    requiredDoses = int.tryParse(
      _requiredDosesController.text.trim(),
    );

    if (requiredDoses == null || requiredDoses <= 0) {
      showNotification(
        context,
        'Number of doses must be greater than 0.',
        success: false,
      );
      return;
    }
  }

  final request = AddVaccinationRequest(
    petId: widget.petId,
    seriesId: _selectedSeries?.id,
    vaccineName: _isNewSeries
        ? _vaccineNameController.text.trim()
        : null,
    requiredDoses: requiredDoses,
    vaccinationDate: _vaccinationDate!,
    notes: _notesController.text.trim().isEmpty
        ? null
        : _notesController.text.trim(),
  );

  final result = await ref
      .read(
        vaccinationNotifierProvider(widget.petId).notifier,
      )
      .addVaccination(request);

  if (!mounted) return;

  if (result is Failure<void>) {
    showNotification(
      context,
      result.message,
      success: false,
    );
    return;
  }

  showNotification(
    context,
    'Vaccination added successfully',
  );

  Navigator.of(context).pop();
}

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final vaccinationState =
        ref.watch(
      vaccinationRecordProvider(widget.petId),
    );

    final seriesState =
        ref.watch(
      vaccinationSerieProvider(widget.petId),
    );

    return Scaffold(
      backgroundColor: Colors.white,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: UnconstrainedBox(
          child: AppCloseButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
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
            onPressed: vaccinationState.isLoading
                ? null
                : _addVaccination,
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

      // ========================================================
      // BODY
      // ========================================================

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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    // ==================================================
                    // VACCINATION SERIES
                    // ==================================================

                    const FieldLabel(
                      label: 'VACCINATION SERIES',
                    ),

                    const SizedBox(height: 8),

                    // ==================================================
                    // NEW SERIES CARD
                    // ==================================================

                    AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 200),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _isNewSeries
                            ? Colors.white
                            : Colors.grey.shade50,
                        borderRadius:
                            BorderRadius.circular(14),
                        border: Border.all(
                          color: _isNewSeries
                              ? AppColors.primary
                                  .withOpacity(0.35)
                              : Colors.grey.shade200,
                        ),
                        boxShadow: _isNewSeries
                            ? [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.06),
                                  blurRadius: 10,
                                  offset:
                                      const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        children: [

                          // Header
                          InkWell(
                            borderRadius:
                                BorderRadius.circular(14),
                            onTap: () {
                              setState(() {
                                _isNewSeries = true;
                                _selectedSeries = null;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 14,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _isNewSeries
                                        ? Icons
                                            .radio_button_checked
                                        : Icons
                                            .radio_button_unchecked,
                                    size: 21,
                                    color: _isNewSeries
                                        ? AppColors.primary
                                        : Colors.grey.shade500,
                                  ),

                                  const SizedBox(width: 10),

                                  const Expanded(
                                    child: Text(
                                      'Create new series',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight:
                                            FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  Icon(
                                    _isNewSeries
                                        ? Icons
                                            .keyboard_arrow_up_rounded
                                        : Icons
                                            .add_circle_outline,
                                    size: 21,
                                    color: _isNewSeries
                                        ? AppColors.primary
                                        : Colors.grey.shade600,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // New series fields
                          if (_isNewSeries) ...[
                            Divider(
                              height: 1,
                              color: Colors.grey.shade200,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(
                                14,
                                14,
                                14,
                                16,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [

                                  const FieldLabel(
                                    label: 'VACCINE NAME',
                                  ),

                                  const SizedBox(height: 6),

                                  CustomeTextField(
                                    controller:
                                        _vaccineNameController,
                                    hintText: 'e.g. Rabies',
                                    validator: (value) {
                                      if (value == null ||
                                          value
                                              .trim()
                                              .isEmpty) {
                                        return
                                            'Vaccine name is required';
                                      }

                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 14),

                                  const FieldLabel(
                                    label: 'NUMBER OF DOSES',
                                  ),

                                  const SizedBox(height: 6),

                                  CustomeTextField(
                                    controller:
                                        _requiredDosesController,
                                    hintText: 'e.g. 3',
                                    keyboardType:
                                        TextInputType.number,
                                    validator: (value) {
                                      final doses =
                                          int.tryParse(
                                        value?.trim() ?? '',
                                      );

                                      if (doses == null ||
                                          doses <= 0) {
                                        return
                                            'Enter a valid number of doses';
                                      }

                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ==================================================
                    // EXISTING SERIES CARD
                    // ==================================================

                    AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 200),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: !_isNewSeries
                            ? Colors.white
                            : Colors.grey.shade50,
                        borderRadius:
                            BorderRadius.circular(14),
                        border: Border.all(
                          color: !_isNewSeries
                              ? AppColors.primary
                                  .withOpacity(0.35)
                              : Colors.grey.shade200,
                        ),
                        boxShadow: !_isNewSeries
                            ? [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.06),
                                  blurRadius: 10,
                                  offset:
                                      const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        children: [

                          // Header
                          InkWell(
                            borderRadius:
                                BorderRadius.circular(14),
                            onTap: () {
                              setState(() {
                                _isNewSeries = false;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 14,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    !_isNewSeries
                                        ? Icons
                                            .radio_button_checked
                                        : Icons
                                            .radio_button_unchecked,
                                    size: 21,
                                    color: !_isNewSeries
                                        ? AppColors.primary
                                        : Colors.grey.shade500,
                                  ),

                                  const SizedBox(width: 10),

                                  const Expanded(
                                    child: Text(
                                      'Use existing series',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight:
                                            FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  Icon(
                                    !_isNewSeries
                                        ? Icons
                                            .keyboard_arrow_up_rounded
                                        : Icons
                                            .keyboard_arrow_right_rounded,
                                    size: 21,
                                    color: !_isNewSeries
                                        ? AppColors.primary
                                        : Colors.grey.shade600,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Existing series selector
                          if (!_isNewSeries) ...[
                            Divider(
                              height: 1,
                              color: Colors.grey.shade200,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(
                                14,
                                14,
                                14,
                                16,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [

                                  const FieldLabel(
                                    label: 'SELECT SERIES',
                                  ),

                                  const SizedBox(height: 6),

                                  InkWell(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                    onTap: seriesState.isLoading
                                        ? null
                                        : _selectExistingSeries,
                                    child: Container(
                                      width: double.infinity,
                                      padding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 14,
                                      ),
                                      decoration:
                                          BoxDecoration(
                                        color:
                                            Colors.grey.shade50,
                                        border: Border.all(
                                          color: Colors
                                              .grey.shade200,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(
                                          12,
                                        ),
                                      ),
                                      child: Row(
                                        children: [

                                          Icon(
                                            Icons
                                                .vaccines_outlined,
                                            size: 20,
                                            color: Colors
                                                .grey.shade600,
                                          ),

                                          const SizedBox(width: 10),

                                          Expanded(
                                            child: seriesState
                                                    .isLoading
                                                ? const Text(
                                                    'Loading series...',
                                                  )
                                                : _selectedSeries ==
                                                        null
                                                    ? Text(
                                                        'Select a series',
                                                        style:
                                                            TextStyle(
                                                          color: Colors
                                                              .grey
                                                              .shade600,
                                                        ),
                                                      )
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [

                                                          Text(
                                                            _selectedSeries!
                                                                .vaccineName,
                                                            style:
                                                                const TextStyle(
                                                              fontSize:
                                                                  14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),

                                                          const SizedBox(
                                                            height: 3,
                                                          ),

                                                          Text(
                                                            '${_selectedSeries!.completedDoses}/${_selectedSeries!.requiredDoses} doses completed',
                                                            style:
                                                                TextStyle(
                                                              fontSize:
                                                                  12,
                                                              color: Colors
                                                                  .grey
                                                                  .shade600,
                                                            ),
                                                          ),

                                                          const SizedBox(
                                                            height: 3,
                                                          ),

                                                          Text(
                                                            'Next dose: ${_selectedSeries!.completedDoses + 1}',
                                                            style:
                                                                TextStyle(
                                                              fontSize:
                                                                  12,
                                                              color: AppColors
                                                                  .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                          ),

                                          Icon(
                                            Icons
                                                .keyboard_arrow_down_rounded,
                                            color: Colors
                                                .grey.shade600,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  if (!seriesState.isLoading &&
                                      seriesState.hasValue &&
                                      seriesState.value!.where(
                                        (serie) =>
                                            serie.completedDoses <
                                            serie.requiredDoses,
                                      ).isEmpty)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(
                                        top: 8,
                                      ),
                                      child: Text(
                                        'No active vaccination series found. '
                                        'Create a new series instead.',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors
                                              .grey.shade600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // ==================================================
                    // VACCINATION DATE
                    // ==================================================

                    const SizedBox(height: 20),

                    const FieldLabel(
                      label: 'VACCINATION DATE',
                    ),

                    const SizedBox(height: 6),

                    CustomeTextField(
                      controller:
                          _vaccinationDateController,
                      hintText: 'mm/dd/yyyy',
                      readOnly: true,
                      onTap: _selectVaccinationDate,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return
                              'Vaccination date is required';
                        }

                        return null;
                      },
                      suffixIcon: const Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: Color(0xFF7A869A),
                      ),
                    ),

                    // ==================================================
                    // NOTES
                    // ==================================================

                    const SizedBox(height: 18),

                    const FieldLabel(
                      label: 'NOTES',
                    ),

                    const SizedBox(height: 6),

                    CustomeTextField(
                      controller: _notesController,
                      hintText:
                          'Optional notes about this vaccination...',
                      maxLines: 4,
                    ),

                    const SizedBox(height: 28),

                    // ==================================================
                    // ADD BUTTON
                    // ==================================================

                    AppPrimaryButton(
                      onPressed:
                          vaccinationState.isLoading
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

          // ========================================================
          // LOADING OVERLAY
          // ========================================================

          if (vaccinationState.isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(0.1),
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
              ),
            ),
        ],
      ),
    );
  }
    }