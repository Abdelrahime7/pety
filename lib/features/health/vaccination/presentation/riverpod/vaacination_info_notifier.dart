import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/core/dependencies inection/di.dart';
import 'package:pet_care/features/health/vaccination/data/vaccination_item_info.dart';

class VaccinationInfoNotifier
    extends FamilyAsyncNotifier<VaccItemInfo, String> {


   

  @override
  FutureOr<VaccItemInfo> build(String petId) async {
   final service = ref.read(vaccinationServiceProvider);
    debugPrint("pet id = $petId");
    final result = await service.getVaccinationInfo(petId);

    if (result is Success<VaccItemInfo>) {
      return result.data;
    }
   
    throw Exception(
      result is Failure<VaccItemInfo>
          ? result.message
          : 'Something went wrong',
    );
  }
}
