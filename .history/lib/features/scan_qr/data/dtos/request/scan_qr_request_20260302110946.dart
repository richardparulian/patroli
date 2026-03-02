import 'package:json_annotation/json_annotation.dart';

part 'scan_qr_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ScanQrRequest {
  final String name;

  ScanQrRequest({
    required this.name,
  });

  factory ScanQrRequest.fromJson(Map<String, dynamic> json) =>
      _$ScanQrRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ScanQrRequestToJson(this);

  @override
  String toString() => 'ScanQr(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScanQrRequest && other.name == name;
  }

  @override
  int get hashCode => Object.hash(name);
}
