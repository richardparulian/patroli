import 'package:json_annotation/json_annotation.dart';
import '../../models/pre_sign_model.dart';

part 'pre_sign_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PreSignResponse {
  final PreSignModel pre_sign;

  PreSignResponse({
    required this.pre_sign,
  });

  factory PreSignResponse.fromJson(Map<String, dynamic> json) =>
      _$PreSignResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PreSignResponseToJson(this);

  @override
  String toString() => 'PreSign(pre_sign: $pre_sign)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PreSignResponse && other.pre_sign == pre_sign;
  }

  @override
  int get hashCode => Object.hash(pre_sign, runtimeType);
}
