import 'package:json_annotation/json_annotation.dart';

part 'scan_qr_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ScanQrRequest {
  final String qrcode;

  ScanQrRequest({
    required this.qrcode,
  });

  factory ScanQrRequest.fromJson(Map<String, dynamic> json) => _$ScanQrRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ScanQrRequestToJson(this);

  ScanQrRequest copyWith({String? qrcode}) {
    return ScanQrRequest(
      qrcode: qrcode ?? this.qrcode,
    );
  }

  @override
  String toString() => 'ScanQr(qrcode: $qrcode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScanQrRequest && other.qrcode == qrcode;
  }

  @override
  int get hashCode => Object.hash(qrcode);
}
