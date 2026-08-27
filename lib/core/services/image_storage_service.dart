

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pet_care/core/constant/result/result.dart';
import 'package:pet_care/infrastructure/networks/dio/Dio_exceptions_mapper.dart';
import 'package:pet_care/infrastructure/cloudinary/cloudinary_service.dart';

class ImageService {
  final CloudinaryService _cloudinaryService;

  ImageService(this._cloudinaryService);
Future<Result<String>> uploadImage({
  required File image,
  required String folder,
  required String publicId,
}) async {
  try {
    final secureUrl = await _cloudinaryService.uploadImage(
      image: image,
      folder: folder,
      publicId: publicId,
    );

    return Success(secureUrl);
  } on DioException catch (e) {
    return Failure(
      mapDioExceptionToFailure(e).toString()
    );
  } catch (e) {
    return Failure(
      e.toString(),
    );
  }
}
}


