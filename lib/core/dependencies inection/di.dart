import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/services/authetication/auth_service.dart';
import 'package:pet_care/infrastructure/firebase/auth/firebase_auth_data_source.dart';




final firbasedatasourceProvider = Provider<FirebaseAuthDataSource>((ref){
return FirebaseAuthDataSource (  FirebaseAuth.instance)
 ;
}); 

final authenticationServiceProvider =
    Provider<AuthenticationService>((ref) {
      final _datasurce = ref.read(firbasedatasourceProvider);
  return AuthenticationService(dataSource:_datasurce
  );

});

