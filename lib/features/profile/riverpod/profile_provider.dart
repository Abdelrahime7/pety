import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/features/authentication/domain/entity/user.dart';

final currentUserProvider = FutureProvider<User?>((ref) async {
  final authUser = auth.FirebaseAuth.instance.currentUser;
  if (authUser == null) return null;
  
  final userService = ref.read(userServiceProvider);
  final result = await userService.getUser(authUser.uid);
  
  switch (result) {
    case Success(:final data):
      return data;
    case Failure():
      return null;
    default:
      return null;
  }
});
