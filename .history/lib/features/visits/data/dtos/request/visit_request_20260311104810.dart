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
    return VisitRequest(
      lightsStatus: lightsStatus ?? this.lightsStatus,
      bannerStatus: bannerStatus ?? this.bannerStatus,
      rollingDoorStatus: rollingDoorStatus ?? this.rollingDoorStatus,
      conditionRight: conditionRight ?? this.conditionRight,
      conditionLeft: conditionLeft ?? this.conditionLeft,
      conditionBack: conditionBack ?? this.conditionBack,
      conditionAround: conditionAround ?? this.conditionAround,
      notes: notes ?? this.notes,
    );
  }

  @override
  String toString() => 'VisitRequest(lightsStatus: $lightsStatus, bannerStatus: $bannerStatus, rollingDoorStatus: $rollingDoorStatus, conditionRight: $conditionRight, conditionLeft: $conditionLeft, conditionBack: $conditionBack, conditionAround: $conditionAround, notes: $notes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VisitRequest && other.lightsStatus == lightsStatus && other.bannerStatus == bannerStatus && other.rollingDoorStatus == rollingDoorStatus && other.conditionRight == conditionRight && other.conditionLeft == conditionLeft && other.conditionBack == conditionBack && other.conditionAround == conditionAround && other.notes == notes;
  }

  @override
  int get hashCode => Object.hash(lightsStatus, bannerStatus, rollingDoorStatus, conditionRight, conditionLeft, conditionBack, conditionAround, notes);
}
