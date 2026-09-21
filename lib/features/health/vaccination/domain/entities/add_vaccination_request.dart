class AddVaccinationRequest {
  final String petId;
  final String? seriesId;
  final String? vaccineName;
  final int? requiredDoses;
  final DateTime vaccinationDate;
  final String? notes;

  const AddVaccinationRequest({
    required this.petId,
    this.seriesId,
    this.vaccineName,
    this.requiredDoses,
    required this.vaccinationDate,
    this.notes,
  });

  bool get isNewSeries => seriesId == null;
}