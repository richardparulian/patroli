import 'package:json_annotation/json_annotation.dart';
import 'package:pos/features/scan_qr/data/models/scan_qr_model.dart';

part 'scan_qr_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ScanQrResponse {
  final ScanQrModel data;

  ScanQrResponse({
    required this.data,
  });

  factory ScanQrResponse.fromJson(Map<String, dynamic> json) => _$ScanQrResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScanQrResponseToJson(this);

  @override
  String toString() => 'ScanQr(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScanQrResponse && other.data == data;
  }

  @override
  int get hashCode => Object.hash(data, runtimeType);
}
