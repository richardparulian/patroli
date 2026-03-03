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
  String toString() => 'CheckIn(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CheckInRequest && other.branchId == branchId && other.selfieCheckIn == selfieCheckIn;
  }

  @override
  int get hashCode => Object.hash(branchId, selfieCheckIn);
}


import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginRequest {
  final String username;
  final String password;

  const LoginRequest({required this.username, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  LoginRequest copyWith({String? username, String? password}) {
    return LoginRequest(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  String toString() => 'LoginRequest(username: $username, password: ****)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginRequest && other.username == username && other.password == password;
  }

  @override
  int get hashCode => Object.hash(username, password);
}
