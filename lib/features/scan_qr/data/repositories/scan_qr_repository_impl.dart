import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/scan_qr/data/datasources/scan_qr_remote_data_source.dart';
import 'package:patroli/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:patroli/features/scan_qr/domain/repositories/scan_qr_repository.dart';

class ScanQrRepositoryImpl implements ScanQrRepository {
  final ScanQrRemoteDataSource _remoteDataSource;

  ScanQrRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ScanQrEntity>> createScanQr(ScanQrRequest request) async {
    try {
      final response = await _remoteDataSource.createScanQr(request);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
