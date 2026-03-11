import 'package:json_annotation/json_annotation.dart';
import 'package:pos/features/check_out/data/models/check_out_model.dart';

part 'check_out_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckOutResponse {
  final CheckOutModel data;

  CheckOutResponse({
    required this.data,
  });

  factory CheckOutResponse.fromJson(Map<String, dynamic> json) => _$CheckOutResponseFromJson(json); 

  Map<String, dynamic> toJson() => _$CheckOutResponseToJson(this);  
}
