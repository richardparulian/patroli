import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/network/api_client.dart';
import 'package:pos/core/network/api_endpoints.dart';
import 'package:pos/core/providers/network_providers.dart';
import 'package:pos/features/reports/data/dtos/response/reports_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/reports_model.dart';

part 'reports_remote_data_source.g.dart';

abstract class ReportsRemoteDataSource {
  // :: Fetch all reportss
  Future<List<ReportsModel>> fetchReports({int? page, int? limit, int? pagination});
}

class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  final ApiClient _apiClient;

  ReportsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<ReportsModel>> fetchReports({int? page, int? limit, int? pagination}) async {
    final result = await _apiClient.get(ApiEndpoints.visitList, queryParameters: {
      'page': page,
      'per_page': limit,
      'with_pagination': pagination,
    });

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) {
        final reportsResponse = ReportsResponse.fromJson(response);
        return reportsResponse.data;
      },
    );
  }
}

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
}

@riverpod
ReportsRemoteDataSource reportsRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ReportsRemoteDataSourceImpl(apiClient);
}
