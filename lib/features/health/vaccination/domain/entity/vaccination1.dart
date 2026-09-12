
import 'package:cloud_firestore/cloud_firestore.dart';

class Vaccination {
  final String? id;
  final String petId;
  final String vaccineName;
  final DateTime vaccinationDate;
  final DateTime? nextDueDate;
  final String? notes;
  
  Vaccination({required this.id, required this.petId, required this.vaccineName, required this.vaccinationDate, required this.nextDueDate, required this.notes});

  


    factory Vaccination.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return Vaccination(
      id: doc.id,
      petId: data['petId'],
      vaccineName: data['vaccineName'],
      vaccinationDate:
          (data['vaccinationDate'] as Timestamp).toDate(),
      nextDueDate: data['nextDueDate'] != null
          ? (data['nextDueDate'] as Timestamp).toDate()
          : null,
      notes: data['notes'],
    );
  }


  Map<String, dynamic> toFirestore() {
  return {
    'petId': petId,
    'vaccineName': vaccineName,
    'vaccinationDate': Timestamp.fromDate(vaccinationDate),
    'nextDueDate': nextDueDate != null
        ? Timestamp.fromDate(nextDueDate!)
        : null,
    'notes': notes,
  };
}

}
