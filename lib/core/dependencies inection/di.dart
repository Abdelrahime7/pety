import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_care/core/services/authetication/auth_service.dart';
import 'package:pet_care/infrastructure/firebase/auth/%20%20irebase_auth_data_source.dart';




final firbasedatasourceProvider = Provider<FirebaseAuthDataSource>((ref){
return FirebaseAuthDataSource (  FirebaseAuth.instance,googleSignIn:GoogleSignIn.instance)
 ;
}); 

final authenticationServiceProvider =
    Provider<AuthenticationService>((ref) {
      final _datasurce = ref.read(firbasedatasourceProvider);
  return AuthenticationService(dataSource:_datasurce
  );

});

