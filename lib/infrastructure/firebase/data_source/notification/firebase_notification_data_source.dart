import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationDataSource {
  final FirebaseFirestore _firestore;

  NotificationDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('notifications');

  Future<List<Map<String, dynamic>>> getNotifications(
    String userId,
  ) async {
    final snapshot = await _collection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return {
        ...doc.data(),
        'id': doc.id,
      };
    }).toList();
  }

  Future<int> getUnreadCount(String userId) async {
    final snapshot = await _collection
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .count()
        .get();

    return snapshot.count ?? 0;
  }

  Future<void> markAsRead(String notificationId) async {
    await _collection.doc(notificationId).update({
      'isRead': true,
    });
  }
Future<void> saveFcmToken(
  String userId,
  String token,
) async {
  await _firestore
      .collection('users')
      .doc(userId)
      .collection('fcmTokens')
      .doc(token)
      .set({
    'token': token,
    'updatedAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
}


Future<void> deleteFcmToken(
  String userId,
  String token,
) async {
  await _firestore
      .collection('users')
      .doc(userId)
      .collection('fcmTokens')
      .doc(token)
      .delete();
}
}


