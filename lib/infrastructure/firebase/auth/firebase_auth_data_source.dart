import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_care/features/authentication/data/user_data.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;


  FirebaseAuthDataSource(this._auth) ;

  // ignore: pty_constructor_bodies
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


  Future logout() =>  _auth.signOut();
  


   UserResponse?  getCurrentUser() {
    final firebaseUser = _auth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    return (
    uid: firebaseUser.uid,
    email: firebaseUser.email!
    );
  }

  Future<UserCredential> loginWithGoogle() async {
    final googleUser = await _googleSignIn.authenticate();

    final googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return _auth.signInWithCredential(credential);
  }





}
