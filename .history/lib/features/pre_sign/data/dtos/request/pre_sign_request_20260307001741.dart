import 'package:json_annotation/json_annotation.dart';

part 'pre_sign_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PreSignRequest {
  final String filename;

  const PreSignRequest({required this.filename});

  factory PreSignRequest.fromJson(Map<String, dynamic> json) => _$PreSignRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PreSignRequestToJson(this);

  PreSignRequest copyWith({String? filename}) {
    return PreSignRequest(
      filename: filename ?? this.filename,
    );
  }

  @override
  String toString() => 'PreSignRequest(filename: $filename)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PreSignRequest && other.filename == filename;
  }

  @override
  int get hashCode => Object.hash(filename, runtimeType);
}
