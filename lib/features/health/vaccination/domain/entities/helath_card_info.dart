class HealthCardInfo {
  final VaccinationItemInfo vaccination;
  final AppointmentItemInfo appointment;

  const HealthCardInfo({
    required this.vaccination,
    required this.appointment,
  });
}
class VaccinationItemInfo {
  final int doseCount;
  final int activeSeriesCount;

  const VaccinationItemInfo({
    required this.doseCount,
    required this.activeSeriesCount,
  });
}

class AppointmentItemInfo {
  final String? nextDueDate;
  final int ? appointmentCount;

  const AppointmentItemInfo({
    this.nextDueDate,
    this.appointmentCount
    
  });
}