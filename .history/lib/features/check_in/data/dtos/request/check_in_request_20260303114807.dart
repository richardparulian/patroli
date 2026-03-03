import 'package:json_annotation/json_annotation.dart';

part 'check_in_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckInRequest {
  final String name;

  CheckInRequest({
    required this.name,
  });

  factory CheckInRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInRequestToJson(this);

  @override
  String toString() => 'CheckIn(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CheckInRequest && other.name == name;
  }

  @override
  int get hashCode => Object.hash(name, runtimeType);
}
