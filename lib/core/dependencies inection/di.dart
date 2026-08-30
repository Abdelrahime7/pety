import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/services/authetication/auth_service.dart';
import 'package:pet_care/core/services/image_storage_service.dart';
import 'package:pet_care/core/services/users_service.dart';
import 'package:pet_care/infrastructure/cloudinary/cloudinary_service.dart';
import 'package:pet_care/infrastructure/firebase/auth/firebase_auth_data_source.dart';
import 'package:pet_care/infrastructure/firebase/firebase_store/user_data_source.dart';
import 'package:pet_care/infrastructure/firebase/pets/firebase_pet_data_source.dart';
import 'package:pet_care/core/services/pet_service.dart';
import 'package:pet_care/infrastructure/networks/dio/dio_provider.dart';

final userFirestoreDataSourcePrvider = Provider<UserFirestoreDataSource>(
(ref){
  return UserFirestoreDataSource(FirebaseFirestore.instance); 
}
) ;

final userServiceProvider = Provider<UserService>((ref) {
  return UserService(ref.read(userFirestoreDataSourcePrvider));
});

final firbasedatasourceProvider = Provider<FirebaseAuthDataSource>((ref){
return FirebaseAuthDataSource ( FirebaseAuth.instance,
 userdataSource:  ref.read(userFirestoreDataSourcePrvider)
)
 ;
}); 

final authenticationServiceProvider =
    Provider<AuthenticationService>((ref) {
  return AuthenticationService(dataSource:ref.read(firbasedatasourceProvider));
}); 

// ---------------- PETS DI ---------------- //

final petFirestoreDataSourceProvider = Provider<PetFirestoreDataSource>(
  (ref) {
    return PetFirestoreDataSource(FirebaseFirestore.instance);
  },
);

final petServiceProvider = Provider<PetService>(
  (ref) {
    return PetService(
      // We pass the data source into the service exactly as your friend did for Auth/User
      dataSource: ref.read(petFirestoreDataSourceProvider),
    );
  },
);


//  cloudinary and dio 
final cloudinaryServiceProvider = Provider<CloudinaryService>((ref) { 
 return  CloudinaryService(
  ref.read(dioProvider)
 );
});

// image service

final imageServiceProvider = Provider<ImageService>((ref)
{
  return ImageService (
    ref.read(cloudinaryServiceProvider)
  );
}
); 

