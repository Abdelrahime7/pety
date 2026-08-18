
// ignore: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/features/authentication/data/user_data.dart';
import 'package:pet_care/infrastructure/firebase/auth/firebase_auth_data_source.dart';
import 'package:pet_care/infrastructure/firebase/auth/firebase_auth_mapper.dart';


class AuthenticationService {
  final  FirebaseAuthDataSource _dataSource ;

  AuthenticationService({required FirebaseAuthDataSource dataSource}) : _dataSource = dataSource;





  UserResponse? getCurrentUser() {

    return _dataSource.getCurrentUser();
  }

 Future<Result<UserResponse>> login(UserRequest request) async {
  try {
    final credential = await _dataSource.login(request);

    final firebaseUser = credential.user!;

    final userResponse = (
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
    );

    return Success(userResponse);
  } on FirebaseAuthException catch (e) {
    return Failure(
      mapFirebaseExceptionToFailure(e).message,
    );
  }
}

 Future<Result> logout() async {
  try {
      await _dataSource.logout();
  
    return Success(null);
  } on FirebaseAuthException catch (e) {
    return Failure(
      mapFirebaseExceptionToFailure(e).message,
    );
  }
}




Future<Result<UserResponse>> register(UserRequest request) async {
  try {
    final credential = await _dataSource.register(request);

    final firebaseUser = credential.user!;

    final userResponse = (
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
    );

    return Success(userResponse);
  } on FirebaseAuthException catch (e) {
    return Failure(
      mapFirebaseExceptionToFailure(e).message,
    );
  }
}

Future<Result<UserResponse>> loginWithGoogle() async {
  try {
    final credential = await _dataSource.loginWithGoogle();

    final firebaseUser = credential.user;

    if (firebaseUser == null || firebaseUser.email == null) {
      return Failure('Unable to get authenticated user');
    }

    return Success((
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
    ));
  } on GoogleSignInException catch (e) {
    if (e.code == GoogleSignInExceptionCode.canceled) {
      return Cancelled();
    }

    return Failure('Google sign-in failed');
  } on FirebaseAuthException catch (e) {
    return Failure(
      mapFirebaseExceptionToFailure(e).message,
    );
  }
}




}