import 'package:json_annotation/json_annotation.dart';
import '../../models/check_in_model.dart';

part 'check_in_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckInResponse {
  final CheckInModel check_in;

  CheckInResponse({
    required this.check_in,
  });

  factory CheckInResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInResponseToJson(this);

  @override
  String toString() => 'CheckIn(check_in: $check_in)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CheckInResponse && other.check_in == check_in;
  }

  @override
  int get hashCode => Object.hash(check_in, runtimeType);
}
