import 'package:pet_care/features/authentication/domain/enums/subscriptionTier.dart';

class User {
  final String userId;
  final String email;
  final String name;
  final String? photoUrl;
  final SubscriptionTier subscriptionTier;
  final DateTime createdAt;

  const User({
    required this.userId,
    required this.email,
    required this.name,
    this.photoUrl,
    required this.subscriptionTier,
    required this.createdAt,
  });
}