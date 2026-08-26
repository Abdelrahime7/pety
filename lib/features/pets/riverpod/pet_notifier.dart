import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/pet_service.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'package:pet_care/features/pets/domain/entity/pet.dart';

class PetNotifier extends AsyncNotifier<List<Pet>> {
  late final PetService _service;
  String? get _ownerId => FirebaseAuth.instance.currentUser?.uid;

  @override
  FutureOr<List<Pet>> build() async {
    _service = ref.read(petServiceProvider);

    if (_ownerId == null) return [];

    final result = await _service.getPets(_ownerId!);
    if (result is Success) {
      return (result as Success).data;
    }
    return [];
  }

  //  FIX: Copy file to app sandbox before uploading
  Future<File> _copyToAppDirectory(File original) async {
    final dir = await getTemporaryDirectory();
    final newPath = path.join(dir.path, path.basename(original.path));
    return await original.copy(newPath);
  }

  //  Upload image to Cloudinary securely via REST
  Future<String?> _uploadPetImage(File? image, String petId) async {
    if (image == null) return null;
    
    const cloudName = "pxux7q6d";
    const uploadPreset = "PetCare";

    final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..fields['folder'] = "pets" 
      ..fields['public_id'] = petId
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      return data['secure_url']; // This is your Cloudinary Image URL!
    } else {
      throw Exception("Cloudinary upload failed! Status code: ${response.statusCode}");
    }
  }

  // addPet with image upload
  Future<Result<void>> addPet(Pet pet, {File? image}) async {
    state = const AsyncLoading();

    try {
      // 1️ Generate ID before upload
      final petId = DateTime.now().millisecondsSinceEpoch.toString();

      // 2️ Upload image
      final photoUrl = await _uploadPetImage(image, petId);

      // 3️ Build final Pet object
      final petWithOwner = Pet(
        id: petId,
        ownerId: _ownerId ?? '',
        name: pet.name,
        species: pet.species,
        breed: pet.breed,
        gender: pet.gender,
        birthDate: pet.birthDate,
        weight: pet.weight,
        medicalNotes: pet.medicalNotes,
        photoUrl: photoUrl ?? "",
      );

      // 4 Save to Firestore
      final result = await _service.addPet(petWithOwner);

      // 5️ Update state
      if (result is Success) {
        if (_ownerId != null) {
          final updatedPets = await _service.getPets(_ownerId!);
          state = updatedPets is Success
              ? AsyncData((updatedPets as Success).data)
              : const AsyncData([]);
        }
        return result;
      }

      if (result is Failure) {
        state = AsyncError(result.message, StackTrace.current);
        return result;
      }

      return result;
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
      return Failure(e.toString());
    }
  }
}
