import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import '../models/check_in_model.dart';

abstract class CheckInRemoteDataSource {
  // :: Fetch all check_ins
  Future<List<CheckInModel>> fetchCheckIns();
  Future<CheckInModel> fetchCheckIn(int id);
}

class CheckInRemoteDataSourceImpl implements CheckInRemoteDataSource {
  final ApiClient _apiClient;

  CheckInRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<CheckInModel>> fetchCheckIns() async {
    final result = await _apiClient.get('/check_ins');

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) {
        final List<dynamic> data = response;
        return data
            .map((json) => CheckInModel.fromJson(json))
            .toList();
      },
    );
  }

  @override
  Future<CheckInModel> fetchCheckIn(int id) async {
    final result = await _apiClient.get('/check_ins/$id');

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) => CheckInModel.fromJson(response),
    );
  }
}

// Provider
final checkInRemoteDataSourceProvider =
    Provider<CheckInRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CheckInRemoteDataSourceImpl(apiClient);
});
