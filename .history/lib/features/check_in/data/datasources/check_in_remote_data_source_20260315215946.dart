import 'package:flutter/foundation.dart';
import 'package:patroli/app/network/network_providers.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/core/network/api_endpoints.dart';
import 'package:patroli/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:patroli/features/check_in/data/dtos/response/check_in_response.dart';
import 'package:patroli/features/check_in/data/models/check_in_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_in_remote_data_source.g.dart';

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

    debugPrint('result: $result');

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) => CheckInResponse.fromJson(response).data,
    );
  }
}

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
}

@riverpod
CheckInRemoteDataSource checkInRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CheckInRemoteDataSourceImpl(apiClient);
}