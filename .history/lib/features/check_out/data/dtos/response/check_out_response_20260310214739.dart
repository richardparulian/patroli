import 'package:json_annotation/json_annotation.dart';
import 'package:pos/features/check_in/data/models/check_in_model.dart';

part 'check_out_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckOutResponse {
  final CheckInModel data;

  CheckOutResponse({
    required this.data,
  });

  factory CheckInResponse.fromJson(Map<String, dynamic> json) => _$CheckInResponseFromJson(json); 

  Map<String, dynamic> toJson() => _$CheckOutResponseToJson(this);
}
