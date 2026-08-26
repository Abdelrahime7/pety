  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/features/users/data/user_data.dart';

class UserFirestoreDataSource {
  final FirebaseFirestore _firestore;

  UserFirestoreDataSource(this._firestore);

  Future<void> createUser({
    required String uid,
    required String email,
     String ?name,
     String ?photoUrl
  }) async {

    
    await _firestore.collection('users').doc(uid).set({
      'name':name, 
      'photoUrl':photoUrl,
      'email': email,
      'subscriptionTier': 'normal',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> createUserIfNotExists({
  required String uid,
     String? name,
  required String email,
    String ?photoUrl
}) async {
  final doc = _firestore.collection('users').doc(uid);

  if (!(await doc.get()).exists) {
    await createUser(
      uid: uid,
      name: name,
      email: email,
      photoUrl:photoUrl
    );
  }
}

 Future<DocumentSnapshot<Map<String, dynamic>>> getUser(
    String uid,
  ) async {
    return _firestore.collection('users').doc(uid).get();
  }

  Future<void> updateUser(
    UserRequest request
  ) async {
    await _firestore.collection('users').doc(request.uid).set({
      'name': request.name,
      'email': request.email,
      'subscriptionTier':request. subscriptionTier,
    });
  }

  // PATCH - update only specific fields
  Future<void> patchUser(
    String uid,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection('users').doc(uid).update(data);
  }

  // DELETE
  Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }

  // CHECK EXISTENCE
  Future<bool> isUserExists(String uid) async {
    final doc = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    return doc.exists;
  }

      }
  

