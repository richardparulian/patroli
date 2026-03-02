import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/scan_qr_entity.dart';

part 'scan_qr_model.freezed.dart';
part 'scan_qr_model.g.dart';

@freezed
abstract class ScanQrModel with _$ScanQrModel {
  const ScanQrModel._();

  const factory ScanQrModel({
    required int id,
    required String name,
  }) = _ScanQrModel;

  factory ScanQrModel.fromJson(Map<String, dynamic> json) =>
      _$ScanQrModelFromJson(json);

  ScanQrEntity toEntity() => ScanQrEntity(id: id, name: name);
}
