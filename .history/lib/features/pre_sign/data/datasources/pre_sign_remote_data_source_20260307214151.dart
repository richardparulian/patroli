import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_request.dart';
import 'package:pos/features/pre_sign/data/dtos/response/pre_sign_response.dart';
import 'package:pos/features/pre_sign/data/models/pre_sign_model.dart';
import 'package:pos/features/pre_sign/data/models/pre_sign_reponse_model.dart';

abstract class PreSignRemoteDataSource {
  Future<PreSignModel> postPreSign(PreSignRequest request);
  Future<PreSignReponseModel> putPreSign(String url, XFile image);
}

class PreSignRemoteDataSourceImpl implements PreSignRemoteDataSource {
  final ApiClient _apiClient;

  PreSignRemoteDataSourceImpl(this._apiClient);

  @override
  Future<PreSignModel> postPreSign(PreSignRequest request) async {
    final result = await _apiClient.post(ApiEndpoints.preSignUrl, data: request.toJson());

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) => PreSignResponse.fromJson(response).data,
    );
  }

  @override
  Future<PreSignReponseModel> putPreSign(String url, XFile image) async {
    final file = File(image.path);
    final fileBytes = await file.readAsBytes();
    
    final result = await _apiClient.put(url, 
      data: fileBytes, 
      options: Options(
        contentType: 'image/jpeg',
        extra: {
          'skip_auth': true,
        },
      ),
    );

    debugPrint('result: $result');

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) => PreSignReponseModel(
        statusCode: response.statusCode,
        data: response,
      ),
    );
  }
}

final preSignRemoteDataSourceProvider = Provider<PreSignRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return PreSignRemoteDataSourceImpl(apiClient);
});

final apiClientProvider = Provider.autoDispose<ApiClient>((ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
});
