import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/services/authetication/auth_service.dart';
import 'package:pet_care/infrastructure/firebase/auth/firebase_auth_data_source.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/user_data_source.dart';


final userFirestoreDataSourcePrvider = Provider<UserFirestoreDataSource>(
(ref){
  return UserFirestoreDataSource(FirebaseFirestore.instance); 
}
) ;

final firbasedatasourceProvider = Provider<FirebaseAuthDataSource>((ref){
return FirebaseAuthDataSource ( FirebaseAuth.instance,
 userdataSource:  ref.read(userFirestoreDataSourcePrvider)
)
 ;
}); 

final authenticationServiceProvider =
    Provider<AuthenticationService>((ref) {
  return AuthenticationService(dataSource:ref.read(firbasedatasourceProvider)
  );

});

