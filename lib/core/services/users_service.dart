import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/features/authentication/domain/entity/user.dart';
import 'package:pet_care/features/authentication/domain/enums/subscriptionTier.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/firestore_mapprt.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/user_data_source.dart';


class UserService {
  final UserFirestoreDataSource _dataSource;

  UserService(this._dataSource);

  // CREATE
  Future<Result<void>> createUser({
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

  // CREATE IF NOT EXISTS
  Future<Result<void>> createUserIfNotExists({
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

  // GET
  Future<Result<User>> getUser(String uid) async {
    try {
      final doc = await _dataSource.getUser(uid);

      if (!doc.exists || doc.data() == null) {
        return const Failure(
          "somthing went wrong"
        );
      }

      final data = doc.data()!;

      final user = User(
        userId: doc.id,
        email: data['email'] as String,
        name: data['name'] as String,
        photoUrl: data['photoUrl'] as String?,
        subscriptionTier: SubscriptionTier.values.firstWhere(
          (tier) => tier.name == data['subscriptionTier'],
          orElse: () => SubscriptionTier.normal,
        ),
        createdAt: (data['createdAt'] as Timestamp).toDate(),
      );

      return Success(user);
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

  // UPDATE
  Future<Result<void>> updateUser({
    required String uid,
    required String name,
    required String email,
    required String subscriptionTier,
  }) async {
    try {
      await _dataSource.updateUser(
        uid: uid,
        name: name,
        email: email,
        subscriptionTier: subscriptionTier,
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
  Future<Result<void>> deleteUser(String uid) async {
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
  Future<Result<bool>> userExists(String uid) async {
    try {
      final exists = await _dataSource.userExists(uid);

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