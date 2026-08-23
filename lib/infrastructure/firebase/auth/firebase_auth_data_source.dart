import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_care/features/authentication/data/user_data.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/user_data_source.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final UserFirestoreDataSource _userdataSource;


  FirebaseAuthDataSource(this._auth, {required UserFirestoreDataSource userdataSource}) : _userdataSource = userdataSource ;

  // ignore: pty_constructor_bodies
  Future<UserCredential> register (
    UserRequest request
  )async {
    
     final credential = await  _auth.createUserWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
  
     await _userdataSource .createUser(
      uid: credential.user!.uid,
      email: credential.user!.email!,
      name: request.name!
       );
  
  return credential;
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

  final userCredential = await _auth.signInWithCredential(credential);

  await _userdataSource.createUserIfNotExists(
    uid: userCredential.user!.uid,
    email: userCredential.user!.email!,
    name: userCredential.user!.displayName!, 
  );

  return userCredential;
}





}
