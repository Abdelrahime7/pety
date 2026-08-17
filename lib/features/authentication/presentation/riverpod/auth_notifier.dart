
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/authetication/auth_service.dart';
import 'package:pet_care/features/authentication/data/user_data.dart';

class AuthNotifier extends AsyncNotifier<UserResponse?> {

   late final AuthenticationService _service ;

  @override
FutureOr<UserResponse?>  build() {
  _service = ref.read(authenticationServiceProvider);
  return _service.getCurrentUser();
  
}

Future<Result<UserResponse>> login(UserRequest request) async {
  state = const AsyncLoading();

  final result = await _service.login(request);

  switch (result) {
    case Success(:final data):
      state = AsyncData(data);
      return result;

    case Failure(:final message):
      state = AsyncError(message, StackTrace.current);
      return result;

      case Cancelled():
      return result;
      
  }
}

Future <Result> logout()async 
{
  state = const AsyncLoading();
  final result = await _service.logout();
 switch (result) {
    case Success(:final data):
      state = AsyncData(data);
      return result;

    case Failure(:final message):
      state = AsyncError(message, StackTrace.current);
      return result;

      case Cancelled():
      return result;

}

}
Future<Result<UserResponse>> register(UserRequest request) async {
  state = const AsyncLoading();

  final result = await _service.register(request);

  switch (result) {
    case Success(:final data):
      state = AsyncData(data);
      return result;

    case Failure(:final message):
      state = AsyncError(message, StackTrace.current);
      return result;

case Cancelled():
      return result;

   
  }
}
Future<Result<UserResponse>> loginWithGoogle() async {
  state = const AsyncLoading();

  final result = await _service.loginWithGoogle();

  switch (result) {
    case Success(:final data):
      state = AsyncData(data);
      return result;

    case Failure(:final message):
      state = AsyncError(
        message,
        StackTrace.current,
      );
      return result;

    case Cancelled():
      state = const AsyncData(null);
      return result;
  }
}




}

