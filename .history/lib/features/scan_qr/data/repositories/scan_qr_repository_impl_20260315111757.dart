import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/scan_qr/data/datasources/scan_qr_remote_data_source.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/domain/repositories/scan_qr_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_qr_repository_impl.g.dart';

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

@riverpod
ScanQrRepository scanQrRepository(Ref ref) {
  final remoteDataSource = ref.watch(scanQrRemoteDataSourceProvider);
  return ScanQrRepositoryImpl(remoteDataSource);
}
