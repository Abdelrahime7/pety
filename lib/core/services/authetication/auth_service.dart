
// ignore: non_constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_care/core/result/resut.dart';
import 'package:pet_care/infrastructure/firebase/auth/%20%20irebase_auth_data_source.dart';
import 'package:pet_care/infrastructure/firebase/auth/firebase_auth_mapper.dart';

typedef UserRequest = ({
  String email,
  String password,
});

typedef UserResponse = ({
  String uid,
  String email,
});

class AuthenticationService {
final FirebaseAuthDataSource _dataSource ;

AuthenticationService({required FirebaseAuthDataSource dataSource}) : _dataSource = dataSource;

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




}