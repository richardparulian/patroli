import 'package:json_annotation/json_annotation.dart';
import 'package:pos/features/check_in/data/models/check_in_model.dart';

part 'check_in_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckInResponse {
  final CheckInData data;

  CheckInResponse({
    required this.data,
  });

  factory CheckInResponse.fromJson(Map<String, dynamic> json) => _$CheckInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckInData {
  final CheckInModel checkIn;

  const CheckInData({
    required this.checkIn,
  });

  factory CheckInData.fromJson(Map<String, dynamic> json) => _$CheckInDataFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInDataToJson(this);
}
