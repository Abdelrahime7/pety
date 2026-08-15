import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_care/core/services/authetication/auth_service.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _auth;

  FirebaseAuthDataSource(this._auth);

  Future<UserCredential> register(
    UserRequest request
  ) {
    return _auth.createUserWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
  }

  Future<UserCredential> login(
    UserRequest request
  ) {
    return _auth.signInWithEmailAndPassword(
      email:request.email,
      password: request.password,
    );
  }
}
