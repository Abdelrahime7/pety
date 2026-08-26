
import 'package:pet_care/features/users/domain/enums/subscriptionTier.dart';

typedef UserRequest = ({
  String ?uid,
  String ?email,
  String ?password,
  String ?name,
  String ?photoUrl,
  SubscriptionTier ?subscriptionTier
});

typedef UserResponse = ({
  String uid,
  String email,
});