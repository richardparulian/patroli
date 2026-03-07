import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_request.dart';
import 'package:pos/features/pre_sign/data/dtos/response/pre_sign_response.dart';
import '../models/pre_sign_model.dart';

abstract class PreSignRemoteDataSource {
  Future<PreSignModel> postPreSign(PreSignRequest request);
  Future<PreSignModel> putPreSign(String url);
}

class PreSignRemoteDataSourceImpl implements PreSignRemoteDataSource {
  final ApiClient _apiClient;

  PreSignRemoteDataSourceImpl(this._apiClient);

  @override
  Future<PreSignModel> postPreSign(PreSignRequest request) async {
    final result = await _apiClient.post(ApiEndpoints.preSignUrl, data: request.toJson());

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) {
        final preSignResponse = PreSignResponse.fromJson(response);  
        debugPrint('preSignResponse: ${preSignResponse.data.data}');
        return preSignResponse.data.data;
      },
    );
  }

  @override
  Future<PreSignModel> putPreSign(String url) async {
    final result = await _apiClient.put(url);

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) => PreSignModel.fromJson(response),
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
