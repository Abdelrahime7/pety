import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/features/users/domain/enums/subscriptionTier.dart';

class User {
  final String userId;
  final String email;
  final String name;
  final String? photoUrl;
  final SubscriptionTier subscriptionTier;
  final DateTime createdAt;

  User({
    required this.userId,
    required this.email,
    required this.name,
    this.photoUrl,
    required this.subscriptionTier,
    required this.createdAt,
  });

  factory User.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return User(
      userId: id,
      email:map['email'] as String? ?? '',
      name: map['name'] as String,
      photoUrl: map['photoUrl'] as String?,
      subscriptionTier: SubscriptionTier.values.firstWhere(
        (tier) => tier.name == map['subscriptionTier'],
        orElse: () => SubscriptionTier.normal,
      ),
       createdAt: map['createdAt'] is Timestamp
        ? (map['createdAt'] as Timestamp).toDate()
        : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'subscriptionTier': subscriptionTier.name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}