import 'package:json_annotation/json_annotation.dart';
import '../../models/scan_qr_model.dart';

part 'scan_qr_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ScanQrResponse {
  final ScanQrModel scan_qr;

  ScanQrResponse({
    required this.scan_qr,
  });

  factory ScanQrResponse.fromJson(Map<String, dynamic> json) => _$ScanQrResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScanQrResponseToJson(this);

  @override
  String toString() => 'ScanQr(scan_qr: $scan_qr)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScanQrResponse && other.scan_qr == scan_qr;
  }

  @override
  int get hashCode => Object.hash(scan_qr, runtimeType);
}
