import 'package:json_annotation/json_annotation.dart';
import 'package:pos/features/scan_qr/data/models/scan_qr_model.dart';

part 'scan_qr_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ScanQrResponse {
  final ScanQrModel data;

  const ScanQrResponse({
    required this.data,
  });

  factory ScanQrResponse.fromJson(Map<String, dynamic> json) => _$ScanQrResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScanQrResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ScanQrData {
  final ScanQrModel data;

  const ScanQrData({
    required this.data,
  });

  factory ScanQrData.fromJson(Map<String, dynamic> json) => _$ScanQrDataFromJson(json);

  Map<String, dynamic> toJson() => _$ScanQrDataToJson(this);
}
