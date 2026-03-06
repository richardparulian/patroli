import 'package:json_annotation/json_annotation.dart';

part 'pre_sign_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PreSignRequest {
  final String name;

  PreSignRequest({
    required this.name,
  });

  factory PreSignRequest.fromJson(Map<String, dynamic> json) =>
      _$PreSignRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PreSignRequestToJson(this);

  @override
  String toString() => 'PreSign(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PreSignRequest && other.name == name;
  }

  @override
  int get hashCode => Object.hash(name, runtimeType);
}
