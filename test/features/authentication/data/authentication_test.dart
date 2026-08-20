

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/services/authetication/auth_service.dart';

import 'package:pet_care/features/authentication/data/user_data.dart';
import 'package:pet_care/infrastructure/firebase/auth/firebase_auth_data_source.dart';

class MockFirebaseAuthDataSource extends Mock
    implements FirebaseAuthDataSource {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuthDataSource dataSource;
  late AuthenticationService service;

  
  setUpAll(() {
    registerFallbackValue((
      email: 'test@gmail.com',
      password: '12345678',
    ));
  });


setUp(() {
  dataSource = MockFirebaseAuthDataSource();

  service = AuthenticationService(
    dataSource: dataSource,
  );
});

  group('login', () {
    test('returns Success when login succeeds', () async {
      final credential = MockUserCredential();
      final user = MockUser();

      when(() => credential.user).thenReturn(user);
      when(() => user.uid).thenReturn('123');
      when(() => user.email).thenReturn('test@gmail.com');

      when(
        () => dataSource.login(any()),
      ).thenAnswer((_) async => credential);

      final result = await service.login((
        email: 'test@gmail.com',
        password: '12345678',
      ));

      expect(result, isA<Success<UserResponse>>());

      final success = result as Success<UserResponse>;

      expect(success.data.uid, '123');
      expect(success.data.email, 'test@gmail.com');
    });

    test('returns Failure when Firebase throws FirebaseAuthException',
        () async {
      when(
        () => dataSource.login(any()),
      ).thenThrow(
        FirebaseAuthException(
          code: 'wrong-password',
        ),
      );

      final result = await service.login((
        email: 'test@gmail.com',
        password: 'wrong-password',
      ));

      expect(result, isA<Failure<UserResponse>>());

      final failure = result as Failure<UserResponse>;

      expect(
        failure.message,
        'Invalid email or password.',
      );
    });

    test('passes email and password to datasource', () async {
      final credential = MockUserCredential();
      final user = MockUser();

      when(() => credential.user).thenReturn(user);
      when(() => user.uid).thenReturn('123');
      when(() => user.email).thenReturn('test@gmail.com');

      when(
        () => dataSource.login(any()),
      ).thenAnswer((_) async => credential);

      final request = (
        email: 'test@gmail.com',
        password: '12345678',
      );

      await service.login(request);

      verify(
        () => dataSource.login(request),
      ).called(1);
    });
  });
}