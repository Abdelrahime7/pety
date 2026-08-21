
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_care/core/errors/failure.dart';

ErrorFailure mapFirebaseExceptionToFailure(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-credential':
     return InvalidCredentialsFailure();

    case 'user-not-found':
      return const UserNotFoundFailure();

      case "No account found with this email":
       return const UserNotFoundFailure();

    case 'wrong-password':
      return const InvalidCredentialsFailure();

    case 'email-already-in-use':
      return const EmailAlreadyInUseFailure();
    
    case 'invalid-email':
     return const InvalidCredentialsFailure();


    case 'user-disabled':
    return const UserDisabledFailure();

    case 'weak-password':
      return const WeakPasswordFailure();

    case 'network-request-failed':
      return const NetworkFailure();
   
    case 'The email address is badly formatted':
    return const InvalidEmailFailure ();

    case 'requires-recent-login':
    return const RequireLoginAgain();

    case 'too-many-requests':
    return  const TooManyRequestsFailure();
      

    

    default:
      return const UnknownAuthFailure();
  }
}