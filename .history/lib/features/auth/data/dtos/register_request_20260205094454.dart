/// Register request DTO
class RegisterRequest {
  final String name;
  final String email;
  final String password;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };

  /// Create copy with modified fields
  RegisterRequest copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return RegisterRequest(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() =>
      'RegisterRequest(name: $name, email: $email, password: ****)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterRequest &&
        other.name == name &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ password.hashCode;
}
