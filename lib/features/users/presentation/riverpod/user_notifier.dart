

import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies%20inection/di.dart';
import 'package:pet_care/core/services/image_storage_service.dart';
import 'package:pet_care/core/services/users_service.dart';
import 'package:pet_care/features/users/data/user_data.dart';
import 'package:pet_care/features/users/domain/enitiy/user.dart';

class UserNotifier extends AsyncNotifier<User> {
late final UserService _userService;
late final ImageService _imageService;
   
  @override
Future<User> build() async {
  _userService = ref.read(userServiceProvider);
  _imageService = ref.read(imageServiceProvider);

  final authUser =
      ref.read(authenticationServiceProvider).getCurrentUser();

  if (authUser == null) {
    throw Exception('User not authenticated');
  }

  final result = await _userService.getUser(authUser.uid);

  switch (result) {
    case Success(:final data):
      return data;

    case Failure(:final message):
      throw Exception(message);

    case Cancelled():
      throw Exception('Get user cancelled');
  }
}

  Future<Result<String>> uploadImage(
  File? image,
  String userId,
) async {
  if (image == null) {
    return Failure("image is null");
  }

  return _imageService.uploadImage(
    image: image,
    folder: 'users',
    publicId: userId,
  );
}


  Future<Result<void>> createUser(String uid, String email) async{
     state = const AsyncLoading();

    final result =  await _userService.createUser(uid: uid, email: email);
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

  // CREATE IF NOT EXISTS
  Future<Result<void>> createUserIfNotExists(String uid ,String email,String name)async{

     state = const AsyncLoading();

    final result =  await _userService.createUserIfNotExists(uid: uid, email: email,name: name);
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

  // GET
  Future<Result<User>> getUser(String uid) async {
    
     state = const AsyncLoading();

    final result =  await _userService.getUser( uid);
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

  // UPDATE
  Future<Result<void>> updateUser(UserRequest request)async{
  
  state = const AsyncLoading();

    final result =  await _userService.updateUser(request);
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

  // PATCH
 Future<Result<void>> patchUser(
  String uid,
  Map<String, dynamic> data,
) async {
  state = const AsyncLoading();

  try {
    final result = await _userService
        .patchUser(uid, data)
        .timeout(
          const Duration(seconds: 10),
        );

    switch (result) {
      case Success():
        final updatedUser = await _userService
            .getUser(uid)
            .timeout(
              const Duration(seconds: 1),
            );

        switch (updatedUser) {
          case Success(:final data):
            state = AsyncData(data);

          case Failure(:final message):
            state = AsyncError(
              message,
              StackTrace.current,
            );

          case Cancelled():
            state = AsyncError(
              'Get user cancelled',
              StackTrace.current,
            );
        }

        return result;

      case Failure(:final message):
        state = AsyncError(
          message,
          StackTrace.current,
        );
        return result;

      case Cancelled():
        state = AsyncError(
          'Patch user cancelled',
          StackTrace.current,
        );
        return result;
    }
  } on TimeoutException {
    state = AsyncError(
      'Request timed out. Please check your internet connection.',
      StackTrace.current,
    );

    return const Failure(
      'Request timed out. Please check your internet connection.',
    );
  } catch (e, stackTrace) {
    state = AsyncError(e, stackTrace);

    return Failure(e.toString());
  }
}
   

  

  // DELETE
  Future<Result<void>> deleteUser(String uid) async {

     state = const AsyncLoading();

    final result =  await _userService.deleteUser(uid);
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
  // EXISTS
  Future<Result<bool>> isUserExists(String uid) async {

    final result =  await _userService.isUserExists(uid);
    switch (result) {
    case Success():
      return result;

    case Failure(:final message):
      state = AsyncError(message, StackTrace.current);
      return result;

    case Cancelled():
      return result;
   
  }
    
  }

  // FIRESTORE EXCEPTION MAPPER
   
Future<void> changeProfilePicture(File image) async {
  

  final currentUser = state.value;

  if (currentUser == null) {
    return;
  }

  final uniquePublicId =
      '${currentUser.userId}_${DateTime.now().millisecondsSinceEpoch}';


  // 1. Upload to Cloudinary
  final imageResult = await uploadImage(
    image,
    uniquePublicId,
  );

  if (imageResult is! Success<String>) {
    return;
  }

  final cloudinaryUrl = imageResult.data;


  // 2. Patch Firestore
  final request = (
    uid: currentUser.userId,
    email: null,
    password: null,
    name: null,
    photoUrl: cloudinaryUrl,
    subscriptionTier: null,
  );

  final data = toPatchMap(request);


    await patchUser(
    currentUser.userId,
    data,
  );

 
}


} 