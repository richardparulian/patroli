import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/features/visits/data/dtos/request/visit_request.dart';
import 'package:pos/features/visits/data/models/visit_model.dart';

abstract class VisitRemoteDataSource { 
  Future<VisitModel> createVisit(VisitRequest request, int reportId);
}

class VisitRemoteDataSourceImpl implements VisitRemoteDataSource {
  final ApiClient _apiClient;

  VisitRemoteDataSourceImpl(this._apiClient);

  @override
  Future<VisitModel> createVisit(VisitRequest request, int reportId) async {
    final endpoint = ApiEndpoints.format(ApiEndpoints.visitUpdate, {'id': reportId.toString()});
    final result = await _apiClient.post(endpoint, data: request.toJson());

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) {
        if (response == null) {
          throw ServerException(message: 'Respon tidak ditemukan');
        }

        return VisitModel.fromJson(response);
      },
    );
  }
}

final visitRemoteDataSourceProvider = Provider<VisitRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return VisitRemoteDataSourceImpl(apiClient);
});

final apiClientProvider = Provider.autoDispose<ApiClient>((ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
});