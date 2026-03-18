import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/core/network/api_endpoints.dart';
import 'package:patroli/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:patroli/features/pre_sign/data/dtos/response/pre_sign_create_response.dart';
import 'package:patroli/features/pre_sign/data/models/pre_sign_create_model.dart';
import 'package:patroli/features/pre_sign/data/models/pre_sign_update_model.dart';

abstract class PreSignRemoteDataSource {
  Future<PreSignCreateModel> postPreSign(PreSignCreateRequest request);
  Future<PreSignUpdateModel> putPreSign(String url, XFile image);
}

class PreSignRemoteDataSourceImpl implements PreSignRemoteDataSource {
  final ApiClient _apiClient;

  PreSignRemoteDataSourceImpl(this._apiClient);

  @override
  Future<PreSignCreateModel> postPreSign(PreSignCreateRequest request) async {
    final result = await _apiClient.post(ApiEndpoints.preSignUrl, data: request.toJson());

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) => PreSignCreateResponse.fromJson(response).data,
    );
  }

  @override
  Future<PreSignUpdateModel> putPreSign(String url, XFile image) async {
    final file = File(image.path);
  
    final originalImage = img.decodeImage(await file.readAsBytes());
    
    if (originalImage == null) {
      throw ServerException(message: 'Gagal membaca gambar');
    }

    // Resize if needed (optional, for optimization) 
    final resizedImage = img.copyResize(
      originalImage,
      width: originalImage.width > 800 ? 800 : null,
      height: originalImage.height > 800 ? 800 : null,
    );
    
    // Fix orientation based on EXIF data
    final fixedImage = img.bakeOrientation(resizedImage);
    final flippedImage = img.flipHorizontal(fixedImage);
    
    // Encode back to JPEG
    final fixedImageBytes = img.encodeJpg(flippedImage, quality: 90);

    
    final result = await _apiClient.put(url, 
      data: fixedImageBytes, 
      options: Options(
        contentType: 'image/jpeg',
        extra: {
          'skip_auth': true,
        },
      ),
    );
    

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) {
        return PreSignUpdateModel(
          statusCode: response.statusCode,
          data: response.data ?? '',
        );
      },
    );
  }
}
