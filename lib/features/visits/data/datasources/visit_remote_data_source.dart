import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/core/network/api_endpoints.dart';
import 'package:patroli/features/visits/data/dtos/request/visit_request.dart';
import 'package:patroli/features/visits/data/dtos/response/visit_response.dart';
import 'package:patroli/features/visits/data/models/visit_model.dart';

abstract class VisitRemoteDataSource { 
  Future<VisitModel> createVisit(VisitRequest request, int reportId);
}

class VisitRemoteDataSourceImpl implements VisitRemoteDataSource {
  final ApiClient _apiClient;

  VisitRemoteDataSourceImpl(this._apiClient);

  @override
  Future<VisitModel> createVisit(VisitRequest request, int reportId) async {
    final endpoint = ApiEndpoints.format(ApiEndpoints.visitDetails, {'id': reportId.toString()});
    final result = await _apiClient.post(endpoint, data: request.toJson());

    return result.fold(
      (failure) => throw ServerException(message: failure.message),
      (response) {
        if (response == null) {
          throw ServerException(message: 'Respon tidak ditemukan');
        }

        return VisitResponse.fromJson(response).data;
      },
    );
  }
}
