import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/data/dtos/response/check_in_response.dart';
import 'package:pos/features/check_in/data/models/check_in_model.dart';

abstract class CheckInRemoteDataSource {
  // :: Fetch all check_ins
  Future<CheckInModel> createCheckIn(CheckInRequest request);
}

class CheckInRemoteDataSourceImpl implements CheckInRemoteDataSource {
  final ApiClient _apiClient;

  CheckInRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CheckInModel> createCheckIn(CheckInRequest request) async {
    final result = await _apiClient.post(ApiEndpoints.visitCreate, data: request.toJson());

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) => CheckInResponse.fromJson(response).data,
    );
  }
}

final checkInRemoteDataSourceProvider = Provider<CheckInRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CheckInRemoteDataSourceImpl(apiClient);
});

final apiClientProvider = Provider.autoDispose<ApiClient>((ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
});