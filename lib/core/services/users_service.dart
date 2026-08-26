import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/features/users/data/user_data.dart';
import 'package:pet_care/features/users/domain/enums/subscriptionTier.dart';
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
  Future<Result> patchUser(
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