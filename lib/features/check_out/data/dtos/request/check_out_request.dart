import 'package:json_annotation/json_annotation.dart';

part 'check_out_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckOutRequest {
  final int branchId;
  final String selfieCheckOut;

  CheckOutRequest({
    required this.branchId,
    required this.selfieCheckOut,
  });

  factory CheckOutRequest.fromJson(Map<String, dynamic> json) => _$CheckOutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutRequestToJson(this);

  CheckOutRequest copyWith({int? branchId, String? selfieCheckOut}) {
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
