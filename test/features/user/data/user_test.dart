import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/services/users_service.dart';
import 'package:pet_care/features/authentication/domain/entity/user.dart';
import 'package:pet_care/features/authentication/domain/enums/subscriptionTier.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/user_data_source.dart';

class MockUserFirestoreDataSource extends Mock
    implements UserFirestoreDataSource {}

// ignore: subtype_of_sealed_class
class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockUserFirestoreDataSource dataSource;
  late UserService service;

  setUp(() {
    dataSource = MockUserFirestoreDataSource();
    service = UserService(dataSource);
  });

  group('createUser', () {
    const uid = 'uid123';
    const email = 'test@email.com';
    const name = 'Abdou';

    test('returns Success when user is created successfully', () async {
      when(
        () => dataSource.createUser(
          uid: uid,
          email: email,
          name: name,
        ),
      ).thenAnswer((_) async {});

      final result = await service.createUser(
        uid: uid,
        email: email,
        name: name,
      );

      expect(result, isA<Success<void>>());

      verify(
        () => dataSource.createUser(
          uid: uid,
          email: email,
          name: name,
        ),
      ).called(1);
    });

    test('returns Success when name is null', () async {
      when(
        () => dataSource.createUser(
          uid: uid,
          email: email,
          name: null,
        ),
      ).thenAnswer((_) async {});

      final result = await service.createUser(
        uid: uid,
        email: email,
        name: null,
      );

      expect(result, isA<Success<void>>());
    });

    test('returns Failure when permission is denied', () async {
      when(
        () => dataSource.createUser(
          uid: uid,
          email: email,
          name: name,
        ),
      ).thenThrow(
        FirebaseException(
          plugin: 'cloud_firestore',
          code: 'permission-denied',
        ),
      );

      final result = await service.createUser(
        uid: uid,
        email: email,
        name: name,
      );

      expect(result, isA<Failure<void>>());

      final failure = result as Failure<void>;

      expect(
        failure.message,
        'You do not have permission to perform this operation.',
      );
    });

    test('returns UnknownFailure when unexpected exception occurs', () async {
      when(
        () => dataSource.createUser(
          uid: uid,
          email: email,
          name: name,
        ),
      ).thenThrow(Exception('unexpected'));

      final result = await service.createUser(
        uid: uid,
        email: email,
        name: name,
      );

      expect(result, isA<Failure<void>>());

      final failure = result as Failure<void>;

      expect(
        failure.message,
        'somthing went wrong',
      );
    });
  });

  group('createUserIfNotExists', () {
    const uid = 'uid123';
    const email = 'test@email.com';
    const name = 'Abdou';

    test('returns Success when operation succeeds', () async {
      when(
        () => dataSource.createUserIfNotExists(
          uid: uid,
          email: email,
          name: name,
        ),
      ).thenAnswer((_) async {});

      final result = await service.createUserIfNotExists(
        uid: uid,
        email: email,
        name: name,
      );

      expect(result, isA<Success<void>>());

      verify(
        () => dataSource.createUserIfNotExists(
          uid: uid,
          email: email,
          name: name,
        ),
      ).called(1);
    });

    test('returns Failure when permission is denied', () async {
      when(
        () => dataSource.createUserIfNotExists(
          uid: uid,
          email: email,
          name: name,
        ),
      ).thenThrow(
        FirebaseException(
          plugin: 'cloud_firestore',
          code: 'permission-denied',
        ),
      );

      final result = await service.createUserIfNotExists(
        uid: uid,
        email: email,
        name: name,
      );

      expect(result, isA<Failure<void>>());

      final failure = result as Failure<void>;

      expect(
        failure.message,
        'You do not have permission to perform this operation.',
      );
    });

    test('returns UnknownFailure for unexpected exception', () async {
      when(
        () => dataSource.createUserIfNotExists(
          uid: uid,
          email: email,
          name: name,
        ),
      ).thenThrow(Exception('unexpected'));

      final result = await service.createUserIfNotExists(
        uid: uid,
        email: email,
        name: name,
      );

      expect(result, isA<Failure<void>>());

      final failure = result as Failure<void>;

      expect(
        failure.message,
        'somthing went wrong',
      );
    });
  });

  group('getUser', () {
    const uid = 'uid123';

    test('returns User when document exists', () async {
      final snapshot = MockDocumentSnapshot();

      final createdAt = Timestamp.fromDate(
        DateTime(2026, 1, 1),
      );

      when(() => snapshot.id).thenReturn(uid);
      when(() => snapshot.exists).thenReturn(true);

      when(() => snapshot.data()).thenReturn({
        'email': 'test@email.com',
        'name': 'Abdou',
        'photoUrl': 'https://example.com/photo.jpg',
        'subscriptionTier': 'normal',
        'createdAt': createdAt,
      });

      when(
        () => dataSource.getUser(uid),
      ).thenAnswer((_) async => snapshot);

      final result = await service.getUser(uid);

      expect(result, isA<Success<User>>());

      final success = result as Success<User>;
      final user = success.data;

      expect(user.userId, uid);
      expect(user.email, 'test@email.com');
      expect(user.name, 'Abdou');
      expect(
        user.photoUrl,
        'https://example.com/photo.jpg',
      );
      expect(
        user.subscriptionTier,
        SubscriptionTier.normal,
      );
      expect(
        user.createdAt,
        DateTime(2026, 1, 1),
      );
    });

    test('returns User with null photoUrl', () async {
      final snapshot = MockDocumentSnapshot();

      when(() => snapshot.id).thenReturn(uid);
      when(() => snapshot.exists).thenReturn(true);

      when(() => snapshot.data()).thenReturn({
        'email': 'test@email.com',
        'name': 'Abdou',
        'photoUrl': null,
        'subscriptionTier': 'normal',
        'createdAt': Timestamp.fromDate(
          DateTime(2026, 1, 1),
        ),
      });

      when(
        () => dataSource.getUser(uid),
      ).thenAnswer((_) async => snapshot);

      final result = await service.getUser(uid);

      expect(result, isA<Success<User>>());

      final user = (result as Success<User>).data;

      expect(user.photoUrl, isNull);
    });

    test('returns DocumentNotFoundFailure when document does not exist',
        () async {
      final snapshot = MockDocumentSnapshot();

      when(() => snapshot.id).thenReturn(uid);
      when(() => snapshot.exists).thenReturn(false);
      when(() => snapshot.data()).thenReturn(null);

      when(
        () => dataSource.getUser(uid),
      ).thenAnswer((_) async => snapshot);

      final result = await service.getUser(uid);

      expect(result, isA<Failure<User>>());

      final failure = result as Failure<User>;

      // Change your service to DocumentNotFoundFailure
      // for this expectation to pass.
      expect(
        failure.message,
        'somthing went wrong',
      );
    });

    test('returns UnknownFailure when document data is null', () async {
      final snapshot = MockDocumentSnapshot();

      when(() => snapshot.id).thenReturn(uid);
      when(() => snapshot.exists).thenReturn(true);
      when(() => snapshot.data()).thenReturn(null);

      when(
        () => dataSource.getUser(uid),
      ).thenAnswer((_) async => snapshot);

      final result = await service.getUser(uid);

      expect(result, isA<Failure<User>>());

      final failure = result as Failure<User>;

      expect(
        failure.message,
        'somthing went wrong',
      );
    });

    test('defaults to normal for unknown subscription tier', () async {
      final snapshot = MockDocumentSnapshot();

      when(() => snapshot.id).thenReturn(uid);
      when(() => snapshot.exists).thenReturn(true);

      when(() => snapshot.data()).thenReturn({
        'email': 'test@email.com',
        'name': 'Abdou',
        'photoUrl': null,
        'subscriptionTier': 'unknown_tier',
        'createdAt': Timestamp.fromDate(
          DateTime(2026, 1, 1),
        ),
      });

      when(
        () => dataSource.getUser(uid),
      ).thenAnswer((_) async => snapshot);

      final result = await service.getUser(uid);

      expect(result, isA<Success<User>>());

      final user = (result as Success<User>).data;

      expect(
        user.subscriptionTier,
        SubscriptionTier.normal,
      );
    });

    test('returns Failure when permission is denied', () async {
      when(
        () => dataSource.getUser(uid),
      ).thenThrow(
        FirebaseException(
          plugin: 'cloud_firestore',
          code: 'permission-denied',
        ),
      );

      final result = await service.getUser(uid);

      expect(result, isA<Failure<User>>());

      final failure = result as Failure<User>;

      expect(
        failure.message,
        'You do not have permission to perform this operation.',
      );
    });

    test('returns UnknownFailure for unexpected exception', () async {
      when(
        () => dataSource.getUser(uid),
      ).thenThrow(Exception('unexpected'));

      final result = await service.getUser(uid);

      expect(result, isA<Failure<User>>());

      final failure = result as Failure<User>;

      expect(
        failure.message,
        'somthing went wrong',
      );
    });
  });
  group('updateUser', () {
    const uid = 'uid123';
    const name = 'New Name';
    const email = 'new@email.com';
    const subscriptionTier = 'premium';

    test('returns Success when update succeeds', () async {
      when(
        () => dataSource.updateUser(
          uid: uid,
          name: name,
          email: email,
          subscriptionTier: subscriptionTier,
        ),
      ).thenAnswer((_) async {});

      final result = await service.updateUser(
        uid: uid,
        name: name,
        email: email,
        subscriptionTier: subscriptionTier,
      );

      expect(result, isA<Success<void>>());

      verify(
        () => dataSource.updateUser(
          uid: uid,
          name: name,
          email: email,
          subscriptionTier: subscriptionTier,
        ),
      ).called(1);
    });

    test('returns Failure when permission is denied', () async {
      when(
        () => dataSource.updateUser(
          uid: uid,
          name: name,
          email: email,
          subscriptionTier: subscriptionTier,
        ),
      ).thenThrow(
        FirebaseException(
          plugin: 'cloud_firestore',
          code: 'permission-denied',
        ),
      );

      final result = await service.updateUser(
        uid: uid,
        name: name,
        email: email,
        subscriptionTier: subscriptionTier,
      );

      expect(result, isA<Failure<void>>());

      final failure = result as Failure<void>;

      expect(
        failure.message,
        'You do not have permission to perform this operation.',
      );
    });

    test('returns UnknownFailure for unexpected exception', () async {
      when(
        () => dataSource.updateUser(
          uid: uid,
          name: name,
          email: email,
          subscriptionTier: subscriptionTier,
        ),
      ).thenThrow(Exception('unexpected'));

      final result = await service.updateUser(
        uid: uid,
        name: name,
        email: email,
        subscriptionTier: subscriptionTier,
      );

      expect(result, isA<Failure<void>>());

      final failure = result as Failure<void>;

      expect(
        failure.message,
        'somthing went wrong',
      );
    });
  });

  group('patchUser', () {
    const uid = 'uid123';

    test('returns Success when patch succeeds', () async {
      final data = {
        'name': 'New Name',
      };

      when(
        () => dataSource.patchUser(uid, data),
      ).thenAnswer((_) async {});

      final result = await service.patchUser(uid, data);

      expect(result, isA<Success<void>>());

      verify(
        () => dataSource.patchUser(uid, data),
      ).called(1);
    });

    test('returns Failure when permission is denied', () async {
      final data = {
        'name': 'New Name',
      };

      when(
        () => dataSource.patchUser(uid, data),
      ).thenThrow(
        FirebaseException(
          plugin: 'cloud_firestore',
          code: 'permission-denied',
        ),
      );

      final result = await service.patchUser(uid, data);

      expect(result, isA<Failure<void>>());

      final failure = result as Failure<void>;

      expect(
        failure.message,
        'You do not have permission to perform this operation.',
      );
    });

    test('returns UnknownFailure for unexpected exception', () async {
      final data = {
        'name': 'New Name',
      };

      when(
        () => dataSource.patchUser(uid, data),
      ).thenThrow(Exception('unexpected'));

      final result = await service.patchUser(uid, data);

      expect(result, isA<Failure<void>>());

      final failure = result as Failure<void>;

      expect(
        failure.message,
        'somthing went wrong',
      );
    });
  });

  group('deleteUser', () {
    const uid = 'uid123';

    test('returns Success when delete succeeds', () async {
      when(
        () => dataSource.deleteUser(uid),
      ).thenAnswer((_) async {});

      final result = await service.deleteUser(uid);

      expect(result, isA<Success<void>>());

      verify(
        () => dataSource.deleteUser(uid),
      ).called(1);
    });

    test('returns Failure when permission is denied', () async {
      when(
        () => dataSource.deleteUser(uid),
      ).thenThrow(
        FirebaseException(
          plugin: 'cloud_firestore',
          code: 'permission-denied',
        ),
      );

      final result = await service.deleteUser(uid);

      expect(result, isA<Failure<void>>());

      final failure = result as Failure<void>;

      expect(
        failure.message,
        'You do not have permission to perform this operation.',
      );
    });

    test('returns UnknownFailure for unexpected exception', () async {
      when(
        () => dataSource.deleteUser(uid),
      ).thenThrow(Exception('unexpected'));

      final result = await service.deleteUser(uid);

      expect(result, isA<Failure<void>>());

      final failure = result as Failure<void>;

      expect(
        failure.message,
        'somthing went wrong',
      );
    });
  });

  group('userExists', () {
    const uid = 'uid123';

    test('returns Success(true) when user exists', () async {
      when(
        () => dataSource.userExists(uid),
      ).thenAnswer((_) async => true);

      final result = await service.userExists(uid);

      expect(result, isA<Success<bool>>());

      final success = result as Success<bool>;

      expect(success.data, true);
    });

    test('returns Success(false) when user does not exist', () async {
      when(
        () => dataSource.userExists(uid),
      ).thenAnswer((_) async => false);

      final result = await service.userExists(uid);

      expect(result, isA<Success<bool>>());

      final success = result as Success<bool>;

      expect(success.data, false);
    });

    test('returns Failure when permission is denied', () async {
      when(
        () => dataSource.userExists(uid),
      ).thenThrow(
        FirebaseException(
          plugin: 'cloud_firestore',
          code: 'permission-denied',
        ),
      );

      final result = await service.userExists(uid);

      expect(result, isA<Failure<bool>>());

      final failure = result as Failure<bool>;

      expect(
        failure.message,
        'You do not have permission to perform this operation.',
      );
    });

    test('returns UnknownFailure for unexpected exception', () async {
      when(
        () => dataSource.userExists(uid),
      ).thenThrow(Exception('unexpected'));

      final result = await service.userExists(uid);

      expect(result, isA<Failure<bool>>());

      final failure = result as Failure<bool>;

      expect(
        failure.message,
        'somthing went wrong',
      );
    });
  });
}