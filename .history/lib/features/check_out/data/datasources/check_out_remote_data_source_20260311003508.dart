import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:pos/features/check_out/data/dtos/response/check_out_response.dart';
import 'package:pos/features/check_out/data/models/check_out_model.dart';

abstract class CheckOutRemoteDataSource { 
  Future<CheckOutModel> createCheckOut(CheckOutRequest request);
}

class CheckOutRemoteDataSourceImpl implements CheckOutRemoteDataSource {
  final ApiClient _apiClient;

  CheckOutRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CheckOutModel> createCheckOut(CheckOutRequest request) async {
    try {
      final result = await _apiClient.post(ApiEndpoints.visitUpdate, data: request.toJson());

      return result.fold(
        (failure) => throw ServerException(message: failure.message),
        (response) => CheckOutResponse.fromJson(response).data,
      );
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on UnauthorizedException {
      rethrow;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
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