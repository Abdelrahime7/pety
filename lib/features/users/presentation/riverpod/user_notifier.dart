

import 'dart:async';
import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/services/users_service.dart';
import 'package:pet_care/features/users/data/user_data.dart';
import 'package:pet_care/features/users/domain/enitiy/user.dart';

class UserNotifier extends AsyncNotifier<User> {
late final UserService _userService;
   
  @override
  FutureOr<User> build() {
    // TODO: implement build
    throw UnimplementedError();
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
  Future<Result<void>> patchUser(String uid,
    Map<String, dynamic> data,) async
  {
  
  state = const AsyncLoading();

    final result =  await _userService.patchUser(uid,data);
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
 


} 