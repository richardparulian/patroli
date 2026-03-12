import 'package:json_annotation/json_annotation.dart';

part 'visit_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VisitRequest {
  final String lightsStatus;
  final String bannerStatus;
  final String rollingDoorStatus;
  final String conditionRight;
  final String conditionLeft;
  final String conditionBack;
  final String conditionAround;
  final String notes;

  VisitRequest({
    required this.lightsStatus,
    required this.bannerStatus,
    required this.rollingDoorStatus,
    required this.conditionRight,
    required this.conditionLeft,
    required this.conditionBack,
    required this.conditionAround,
    required this.notes,
  });

  factory VisitRequest.fromJson(Map<String, dynamic> json) => _$VisitRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VisitRequestToJson(this);

  VisitRequest copyWith({String? lightsStatus, String? bannerStatus, String? rollingDoorStatus, String? conditionRight, String? conditionLeft, String? conditionBack, String? conditionAround, String? notes}) {
    return CheckOutRequest(
      branchId: branchId ?? this.branchId,
      selfieCheckOut: selfieCheckOut ?? this.selfieCheckOut,
    );
  }

  @override
  String toString() => 'CheckOut(branchId: $branchId, selfieCheckOut: $selfieCheckOut)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CheckOutRequest && other.branchId == branchId && other.selfieCheckOut == selfieCheckOut;
  }

  @override
  int get hashCode => Object.hash(branchId, selfieCheckOut);
}
