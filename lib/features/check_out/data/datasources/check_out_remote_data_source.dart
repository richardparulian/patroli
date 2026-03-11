import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:pos/features/check_out/data/models/check_out_model.dart';

abstract class CheckOutRemoteDataSource { 
  Future<CheckOutModel> createCheckOut(CheckOutRequest request, int reportId);
}

class CheckOutRemoteDataSourceImpl implements CheckOutRemoteDataSource {
  final ApiClient _apiClient;

  CheckOutRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CheckOutModel> createCheckOut(CheckOutRequest request, int reportId) async {
    final endpoint = ApiEndpoints.format(ApiEndpoints.visitUpdate, {'id': reportId.toString()});
    final result = await _apiClient.post(endpoint, data: request.toJson());

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) {
        if (response == null) {
          throw ServerException(message: 'Respon tidak ditemukan');
        }

        return CheckOutModel.fromJson(response);
      },
    );
  }
}

final checkOutRemoteDataSourceProvider = Provider<CheckOutRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CheckOutRemoteDataSourceImpl(apiClient);
});

final apiClientProvider = Provider.autoDispose<ApiClient>((ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
});