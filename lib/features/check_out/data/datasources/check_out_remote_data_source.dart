import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/core/network/api_endpoints.dart';
import 'package:patroli/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:patroli/features/check_out/data/models/check_out_model.dart';

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
