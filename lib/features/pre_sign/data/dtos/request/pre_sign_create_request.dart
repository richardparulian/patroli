import 'package:json_annotation/json_annotation.dart';

part 'pre_sign_create_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PreSignCreateRequest {
  final String filename;

  const PreSignCreateRequest({required this.filename});

  factory PreSignCreateRequest.fromJson(Map<String, dynamic> json) => _$PreSignCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PreSignCreateRequestToJson(this);

  PreSignCreateRequest copyWith({String? filename}) {
    return PreSignCreateRequest(
      filename: filename ?? this.filename,
    );
  }

  @override
  String toString() => 'PreSignCreateRequest(filename: $filename)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PreSignCreateRequest && other.filename == filename;
  }

  @override
  int get hashCode => Object.hash(filename, runtimeType);
}
