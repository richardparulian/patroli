import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/exceptions.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/scan_qr/data/datasources/scan_qr_remote_data_source.dart';
import 'package:pos/features/scan_qr/data/models/scan_qr_model.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/domain/repositories/scan_qr_repository.dart';

class ScanQrRepositoryImpl implements ScanQrRepository {
  final ScanQrRemoteDataSource _remoteDataSource;

  ScanQrRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<ScanQrEntity>>> getScanQrs() async {
    try {
      final models = await _remoteDataSource.fetchScanQrs();
      return Right(models.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to fetch scan_qrs'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ScanQrEntity>> getScanQr(int id) async {
    try {
      final model = await _remoteDataSource.fetchScanQr(id);
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to fetch scan_qr'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

// Provider
final scanQrRepositoryProvider =
    Provider<ScanQrRepository>((ref) {
  final remoteDataSource = ref.watch(scanQrRemoteDataSourceProvider);
  return ScanQrRepositoryImpl(remoteDataSource);
});
