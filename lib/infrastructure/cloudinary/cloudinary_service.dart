import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pet_care/core/confige/cloudinary_config.dart';

class CloudinaryService {
  final Dio _dio;

  CloudinaryService(this._dio);

  Future<String> uploadImage({
    required File image,
    required String folder,
    required String publicId,
  }) async {
   

    final url = CloudinaryConfig.url;

    final formData = FormData.fromMap({
      'upload_preset': CloudinaryConfig.uploadPreset,
      'folder': folder,
      'public_id': publicId,
      'file': await MultipartFile.fromFile(
        image.path,
        filename: image.uri.pathSegments.last,
      ),
    });

    final response = await _dio.post(
      url,
      data: formData,
    );

    if (response.statusCode == 200) {
      final secureUrl = response.data['secure_url'];

      if (secureUrl is String) {
        return secureUrl;
      }

    }

    throw Exception(

     'Cloudinary upload failed: ${response.statusCode}',
    );
  }
}