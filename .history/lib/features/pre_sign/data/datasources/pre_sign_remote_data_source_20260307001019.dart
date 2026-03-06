import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/providers/network_providers.dart';
import '../models/pre_sign_model.dart';

abstract class PreSignRemoteDataSource {
  // :: Fetch all pre_signs
  Future<List<PreSignModel>> fetchPreSigns();
  Future<PreSignModel> fetchPreSign(int id);
}

class PreSignRemoteDataSourceImpl implements PreSignRemoteDataSource {
  final ApiClient _apiClient;

  PreSignRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<PreSignModel>> fetchPreSigns() async {
    final result = await _apiClient.get('/pre_signs');

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) {
        final List<dynamic> data = response;
        return data
            .map((json) => PreSignModel.fromJson(json))
            .toList();
      },
    );
  }

  @override
  Future<PreSignModel> fetchPreSign(int id) async {
    final result = await _apiClient.get('/pre_signs/$id');

    return result.fold(
      (failure) => throw Exception(failure.message),
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
