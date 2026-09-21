import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/firestore_mapprt.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/vaccination_data_source.dart';

class VaccinationService<T> {
  final VaccinationDataSource dataSource;

  final String collectionName;

  final T Function(Map<String, dynamic> data) fromMap;

  VaccinationService({
    required this.dataSource,
    required this.collectionName,
    required this.fromMap,
  });

   // ---------------------------------------------------------------------------
  // Count
  // --------------------------------------------------------------------------

Future<Result<int>> count(
    String petid,
  ) async {
    try {
      if (petid.isEmpty) {
        return const Failure(
          'ID is required.',
        );
      }
      
     final result= await dataSource.getCount(
        collectionName,
        petid,
      
      );
    
      return  Success(result);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {
      return Failure(
        e.toString(),
      );
    }
  }
 

   // ---------------------------------------------------------------------------
  // Count
  // --------------------------------------------------------------------------
  
Future<Result<int>> countActivSeries(
    String petid,
  ) async {
    try {
      if (petid.isEmpty) {
        return const Failure(
          'ID is required.',
        );
      }
      
     final result= await dataSource.getActiveSerieCount(
        collectionName,
        petid,
      
      );
    
      return  Success(result);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {
      return Failure(
        e.toString(),
      );
    }
  }
 

  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  Future<Result<void>> create(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      if (id.isEmpty) {
        return const Failure(
          'ID is required.',
        );
      }
      
      await dataSource.create(
        collectionName,
        id,
        data,
      );
    
      return  Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {
      return Failure(
        e.toString(),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // READ ALL
  // ---------------------------------------------------------------------------

  Future<Result<List<T>>> getAll(
    String petId,
  ) async {
    try {
      if (petId.isEmpty) {
        return const Failure(
          'Pet ID is required.',
        );
      }

      final data = await dataSource.getAll(
        collectionName,
        petId,
      );

      final entities = data
          .map(fromMap)
          .toList();

      return Success(entities);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {
      return Failure(
        e.toString(),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // READ ONE
  // ---------------------------------------------------------------------------

  Future<Result<T>> getById(
    String id,
  ) async {
    try {
      if (id.isEmpty) {
        return const Failure(
          'ID is required.',
        );
      }

      final data = await dataSource.getById(
        collectionName,
        id,
      );

      if (data == null) {
        return const Failure(
          'Record not found.',
        );
      }

      return Success(
        fromMap(data),
      );
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {
      return Failure(
        e.toString(),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  Future<Result<void>> update(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      if (id.isEmpty) {
        return const Failure(
          'ID is required.',
        );
      }

      await dataSource.update(
        collectionName,
        id,
        data,
      );

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {
      return Failure(
        e.toString(),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  Future<Result<void>> delete(
    String id,
  ) async {
    try {
      if (id.isEmpty) {
        return const Failure(
          'ID is required.',
        );
      }

      await dataSource.delete(
        collectionName,
        id,
      );

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (e) {
      return Failure(
        e.toString(),
      );
    }
  }
}