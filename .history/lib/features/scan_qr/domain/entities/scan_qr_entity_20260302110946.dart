import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_qr_entity.freezed.dart';

@freezed
abstract class ScanQrEntity with _$ScanQrEntity {
  const factory ScanQrEntity({
    required int id,
    required String name,
  }) = _ScanQrEntity;

  // :: Empty scan_qr
  factory ScanQrEntity.empty() => const ScanQrEntity(id: 0, name: '');
}
