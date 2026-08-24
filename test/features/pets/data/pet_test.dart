import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/services/pet_service.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';
import 'package:pet_care/infrastructure/firebase/pets/firebase_pet_data_source.dart';

class MockPetFirestoreDataSource extends Mock
    implements PetFirestoreDataSource {}

// ignore: subtype_of_sealed_class
class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockPetFirestoreDataSource dataSource;
  late PetService service;

  setUp(() {
    dataSource = MockPetFirestoreDataSource();
    service = PetService(dataSource: dataSource);
    
    registerFallbackValue(
      Pet(
        id: 'fallback',
        ownerId: 'owner',
        name: 'name',
        species: 'species',
        breed: 'breed',
        gender: 'gender',
        birthDate: DateTime.now(),
        weight: 1.0,
        medicalNotes: '',
      ),
    );
  });

  group('addPet', () {
    final pet = Pet(
      id: 'pet123',
      ownerId: 'owner123',
      name: 'Luna',
      species: 'Dog',
      breed: 'Golden Retriever',
      gender: 'Female',
      birthDate: DateTime(2023, 1, 1),
      weight: 72.4,
      medicalNotes: 'None',
      photoUrl: 'url',
    );

    test('returns Success when pet is added successfully', () async {
      when(() => dataSource.addPet(any())).thenAnswer((_) async {});

      final result = await service.addPet(pet);

      expect(result, isA<Success<void>>());
      verify(() => dataSource.addPet(pet)).called(1);
    });

    test('returns Failure when permission is denied', () async {
      when(() => dataSource.addPet(any())).thenThrow(
        FirebaseException(
          plugin: 'cloud_firestore',
          code: 'permission-denied',
        ),
      );

      final result = await service.addPet(pet);

      expect(result, isA<Failure<void>>());
      
      final failure = result as Failure<void>;
      // Based on their mapFirestoreExceptionToFailure
      expect(failure.message, 'You do not have permission to perform this operation.');
    });

    test('returns UnknownFailure when unexpected exception occurs', () async {
      when(() => dataSource.addPet(any())).thenThrow(Exception('unexpected'));

      final result = await service.addPet(pet);

      expect(result, isA<Failure<void>>());
      expect((result as Failure<void>).message, 'Something went wrong');
    });
  });

  group('getPets', () {
    const ownerId = 'owner123';

    test('returns Success<List<Pet>> when pets are fetched', () async {
      final snapshot = MockQueryDocumentSnapshot();
      
      when(() => snapshot.id).thenReturn('pet123');
      when(() => snapshot.data()).thenReturn({
        'ownerId': ownerId,
        'name': 'Luna',
        'species': 'Dog',
        'breed': 'Golden Retriever',
        'gender': 'Female',
        'birthDate': Timestamp.fromDate(DateTime(2023, 1, 1)),
        'weight': 72.4,
        'medicalNotes': 'None',
        'photoUrl': 'url',
      });

      when(() => dataSource.getPets(ownerId)).thenAnswer((_) async => [snapshot]);

      final result = await service.getPets(ownerId);

      expect(result, isA<Success<List<Pet>>>());
      final success = result as Success<List<Pet>>;
      expect(success.data.length, 1);
      
      final pet = success.data.first;
      expect(pet.id, 'pet123');
      expect(pet.name, 'Luna');
      expect(pet.weight, 72.4);
      expect(pet.gender, 'Female');
    });

    test('returns Failure when permission is denied', () async {
      when(() => dataSource.getPets(ownerId)).thenThrow(
        FirebaseException(
          plugin: 'cloud_firestore',
          code: 'permission-denied',
        ),
      );

      final result = await service.getPets(ownerId);

      expect(result, isA<Failure<List<Pet>>>());
      expect((result as Failure<void>).message, 'You do not have permission to perform this operation.');
    });

    test('returns UnknownFailure when unexpected exception occurs', () async {
      when(() => dataSource.getPets(ownerId)).thenThrow(Exception('unexpected'));

      final result = await service.getPets(ownerId);

      expect(result, isA<Failure<List<Pet>>>());
      expect((result as Failure<void>).message, 'Something went wrong');
    });
  });
}
