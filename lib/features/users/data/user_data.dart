
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

Map<String, dynamic> toPatchMap( UserRequest request) {
    final data = <String, dynamic>{};

    if (request.email != null) {
      data['email'] = request.email;
    }

    if (request.name != null) {
      data['name'] = request.name;
    }

    if (request.photoUrl != null) {
      data['photoUrl'] = request.photoUrl;
    }

    if (request.subscriptionTier != null) {
      data['subscriptionTier'] = request.subscriptionTier!.name;
    }

    return data;
  }