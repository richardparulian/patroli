import 'package:json_annotation/json_annotation.dart';

part 'check_in_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckInRequest {
  final int branchId;
  final String selfieCheckIn;

  CheckInRequest({
    required this.branchId,
    required this.selfieCheckIn,
  });

  factory CheckInRequest.fromJson(Map<String, dynamic> json) => _$CheckInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInRequestToJson(this);

  CheckInRequest copyWith({int? branchId, String? selfieCheckIn}) {
    return CheckInRequest(
      branchId: branchId ?? this.branchId,
      selfieCheckIn: selfieCheckIn ?? this.selfieCheckIn,
    );
  }

  @override
  String toString() => 'CheckIn(branchId: $branchId, selfieCheckIn: $selfieCheckIn)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CheckInRequest && other.branchId == branchId && other.selfieCheckIn == selfieCheckIn;
  }

  @override
  int get hashCode => Object.hash(branchId, selfieCheckIn);
}
