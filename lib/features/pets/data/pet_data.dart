typedef PetRequest = ({
  String id,
  String? name,
  String? species,
  String? breed,
  String? gender,
  DateTime? birthDate,
  double? weight,
  String? medicalNotes,
  String? photoUrl,
});

Map<String, dynamic> toPatchMap(PetRequest request) {
  final data = <String, dynamic>{};

  if (request.name != null) {
    data['name'] = request.name;
  }

  if (request.species != null) {
    data['species'] = request.species;
  }

  if (request.breed != null) {
    data['breed'] = request.breed;
  }

  if (request.gender != null) {
    data['gender'] = request.gender;
  }

  if (request.birthDate != null) {
    data['birthDate'] = request.birthDate!.toIso8601String();
  }

  if (request.weight != null) {
    data['weight'] = request.weight;
  }

  if (request.medicalNotes != null) {
    data['medicalNotes'] = request.medicalNotes;
  }

  if (request.photoUrl != null) {
    data['photoUrl'] = request.photoUrl;
  }

  return data;
}