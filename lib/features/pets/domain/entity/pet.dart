import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  final String id;
  final String ownerId;
  final String name;
  final String species;
  final String breed;
  final String gender;
  final DateTime birthDate;
  final double weight;
  final String medicalNotes;
  final String photoUrl;

  const Pet({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.species,
    required this.breed,
    required this.gender,
    required this.birthDate,
    required this.weight,
    required this.medicalNotes,
    this.photoUrl = '',
  });

  // Factory constructor to easily map from Firestore Document
  factory Pet.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Pet(
      id: doc.id,
      ownerId: data['ownerId'] as String? ?? '',
      name: data['name'] as String? ?? '',
      species: data['species'] as String? ?? '',
      breed: data['breed'] as String? ?? '',
      gender: data['gender'] as String? ?? '',
      birthDate: (data['birthDate'] as Timestamp).toDate(),
      weight: (data['weight'] as num?)?.toDouble() ?? 0.0,
      medicalNotes: data['medicalNotes'] as String? ?? '',
      photoUrl: data['photoUrl'] as String? ?? '',
    );
  }

  // Method to easily convert to Map for Firebase saves
  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'name': name,
      'species': species,
      'breed': breed,
      'gender': gender,
      'birthDate': Timestamp.fromDate(birthDate),
      'weight': weight,
      'medicalNotes': medicalNotes,
      'photoUrl': photoUrl,
    };
  }
}
