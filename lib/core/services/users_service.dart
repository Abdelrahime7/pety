import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/features/users/data/user_data.dart';
import 'package:pet_care/features/users/domain/enitiy/user.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/firestore_mapprt.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/user_data_source.dart';


class UserService {
  final UserFirestoreDataSource _dataSource;

  UserService(this._dataSource);

  // CREATE
  Future<Result> createUser({
    required String uid,
    required String email,
     String ?name,
     String ?photoUrl,


  }) async {
    try {
      
       await _dataSource.createUser(
        uid: uid,
        email: email,
        name: name,
      );

      return const Success(User);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message
      );
    } catch (_) {
      return const Failure(
        "somthing went wrong"
      );
    }
  }

  // CREATE IF NOT EXISTS
  Future<Result> createUserIfNotExists({
    required String uid,
    required String email,
    required String name,
  }) async {
    try {
      await _dataSource.createUserIfNotExists(
        uid: uid,
        email: email,
        name: name,
      );

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message
      );
    } catch (_) {
      return const Failure(
        "somthing went wrong"
      );
    }
  }

Future<Result<User>> getUser(String uid) async {
  try {
    final doc = await _dataSource.getUser(uid);

    if (!doc.exists || doc.data() == null) {
      return const Failure('User not found');
    }

    final user = User.fromMap(
      doc.id,
      doc.data()!,
    );

    return Success(user);
  } on FirebaseException catch (e) {
    return Failure(
      mapFirestoreExceptionToFailure(e).message,
    );
  } catch (e) {

    return Failure(e.toString());
  }
}
  // GET
 

  // UPDATE
  Future<Result> updateUser(
   UserRequest request
  ) async {
    try {
      await _dataSource.updateUser(
       request
      );

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (_) {
      return const Failure(
        "somthing went wrong"
      );
    }
  }

  // PATCH
  Future<Result<void>> patchUser(
    String uid,
    Map<String, dynamic> data,
  ) async {
    try {
      await _dataSource.patchUser(
        uid,
        data,
      );

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message,
      );
    } catch (_) {
      return const Failure(
        "somthing went wrong"
      );
    }
  }

  // DELETE
  Future<Result> deleteUser(String uid) async {
    try {
      await _dataSource.deleteUser(uid);

      return const Success(null);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message
      );
    } catch (_) {
      return const Failure(
        "somthing went wrong"
      );
    }
  }

  // EXISTS
  Future<Result<bool>> isUserExists(String uid) async {
    try {
      final exists = await _dataSource.isUserExists(uid);

      return Success(exists);
    } on FirebaseException catch (e) {
      return Failure(
        mapFirestoreExceptionToFailure(e).message
      );
    } catch (_) {
      return const Failure(
        "somthing went wrong"
      );
    }
  }

  // FIRESTORE EXCEPTION MAPPER
 
}