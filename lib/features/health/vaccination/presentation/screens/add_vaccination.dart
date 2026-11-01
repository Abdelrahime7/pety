import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:pet_care/core/constant/widgets/app_close_button.dart';
import 'package:pet_care/core/constant/widgets/custom_text_field.dart';
import 'package:pet_care/core/constant/widgets/primary_button.dart';
import 'package:pet_care/features/authentication/presentation/helpers/helpers.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/add_vaccination_request.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_serie.dart';
import 'package:pet_care/features/health/vaccination/presentation/riverpod/vaccination_providers.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/existing_series_selector.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/new_series_form.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/saving_overlay.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/series_Picker_Sheet.dart';
import 'package:pet_care/features/health/vaccination/presentation/widgets/series_option_card.dart';
import 'package:pet_care/features/pets/widgets/field_label.dart';

class AddVaccinationScreen extends ConsumerStatefulWidget {
  final String petId;

  const AddVaccinationScreen({super.key, required this.petId});

  @override
  ConsumerState<AddVaccinationScreen> createState() =>
      _AddVaccinationScreenState();
}

class _AddVaccinationScreenState extends ConsumerState<AddVaccinationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vaccineNameController = TextEditingController();
  final _requiredDosesController = TextEditingController(text: '3');
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
  // ACTIONS
  // ============================================================

  Future<void> _selectVaccinationDate() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: _vaccinationDate ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    );

    if (picked == null) return;

    setState(() {
      _vaccinationDate = picked;
      _vaccinationDateController.text =
          '${picked.month.toString().padLeft(2, '0')}/'
          '${picked.day.toString().padLeft(2, '0')}/'
          '${picked.year}';
    });
  }

  List<VaccinationSerie> _activeSeries(List<VaccinationSerie> all) =>
      all.where((serie) => serie.completedDoses < serie.requiredDoses).toList();

  Future<void> _selectExistingSeries() async {
    final allSeries =
        ref.read(vaccinationSerieProvider(widget.petId)).value ?? [];
    final activeSeries = _activeSeries(allSeries);

    if (activeSeries.isEmpty) {
      showNotification(
        context,
        'No active vaccination series found.',
        success: false,
      );
      return;
    }

    final selected = await showModalBottomSheet<VaccinationSerie>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SeriesPickerSheet(
        series: activeSeries,
        selectedSeries: _selectedSeries,
      ),
    );

    if (selected == null) return;

    setState(() => _selectedSeries = selected);
  }

  Future<void> _addVaccination() async {
    if (!_formKey.currentState!.validate()) return;

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
      requiredDoses = int.tryParse(_requiredDosesController.text.trim());

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
      ownerId: FirebaseAuth.instance.currentUser!.uid,
      petId: widget.petId,
      seriesId: _selectedSeries?.id,
      vaccineName: _isNewSeries ? _vaccineNameController.text.trim() : null,
      requiredDoses: requiredDoses,
      vaccinationDate: _vaccinationDate!,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    final result = await ref
        .read(vaccinationNotifierProvider(widget.petId).notifier)
        .addVaccination(request);

    if (!mounted) return;

    if (result is Failure<void>) {
      showNotification(context, result.message, success: false);
      return;
    }

    showNotification(context, 'Vaccination added successfully');
    Navigator.of(context).pop();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final vaccinationState = ref.watch(vaccinationRecordProvider(widget.petId));
    final seriesState = ref.watch(vaccinationSerieProvider(widget.petId));
    final isSaving = vaccinationState.isLoading;

    final hasNoActiveSeries =
        !seriesState.isLoading &&
        seriesState.hasValue &&
        _activeSeries(seriesState.value!).isEmpty;

    return Scaffold(
      appBar: _buildAppBar(isSaving),
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
                    const FieldLabel(label: 'VACCINATION SERIES'),
                    const SizedBox(height: 8),

                    SeriesOptionCard(
                      title: 'Create new series',
                      selected: _isNewSeries,
                      collapsedIcon: Icons.add_circle_outline,
                      onTap: () => setState(() {
                        _isNewSeries = true;
                        _selectedSeries = null;
                      }),
                      child: NewSeriesForm(
                        vaccineNameController: _vaccineNameController,
                        requiredDosesController: _requiredDosesController,
                      ),
                    ),

                    const SizedBox(height: 10),

                    SeriesOptionCard(
                      title: 'Use existing series',
                      selected: !_isNewSeries,
                      collapsedIcon: Icons.keyboard_arrow_right_rounded,
                      onTap: () => setState(() => _isNewSeries = false),
                      child: ExistingSeriesSelector(
                        selectedSeries: _selectedSeries,
                        isLoading: seriesState.isLoading,
                        hasNoActiveSeries: hasNoActiveSeries,
                        onTap: _selectExistingSeries,
                      ),
                    ),

                    const SizedBox(height: 20),
                    const FieldLabel(label: 'VACCINATION DATE'),
                    const SizedBox(height: 6),
                    CustomeTextField(
                      controller: _vaccinationDateController,
                      hintText: 'mm/dd/yyyy',
                      readOnly: true,
                      onTap: _selectVaccinationDate,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vaccination date is required';
                        }
                        return null;
                      },
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 18),
                    const FieldLabel(label: 'NOTES'),
                    const SizedBox(height: 6),
                    CustomeTextField(
                      controller: _notesController,
                      hintText: 'Optional notes about this vaccination...',
                      maxLines: 4,
                    ),

                    const SizedBox(height: 28),
                    AppPrimaryButton(
                      onPressed: isSaving ? null : _addVaccination,
                      text: 'Add Vaccination',
                      height: 52,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          if (isSaving) const SavingOverlay(message: 'Saving vaccination…'),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isSaving) {
    return AppBar(
      leading: UnconstrainedBox(
        child: AppCloseButton(onPressed: () => Navigator.of(context).pop()),
      ),
      title: Text(
        'Add Vaccination',
        style: TextStyle(
          color: context.colors.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: isSaving ? null : _addVaccination,
          child: Text(
            'Save',
            style: TextStyle(
              color: isSaving
                  ? context.colors.onSurfaceVariant
                  : context.colors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
