# Auth Data Transfer Objects (DTOs)

## Overview

This directory contains Data Transfer Objects (DTOs) for the Auth feature. DTOs provide type-safe, clean, and maintainable data structures for API requests and responses.

## Structure

```
dtos/
├── login_request.dart          # Login request DTO
├── register_request.dart       # Register request DTO
├── auth_response.dart          # Auth response DTO (login/register)
├── refresh_token_request.dart  # Refresh token request DTO
├── refresh_token_response.dart # Refresh token response DTO
├── dtos.dart                  # Barrel file for convenience
└── README.md                  # This file
```

## Benefits of Using DTOs

### 1. **Type Safety**
Compile-time checking prevents runtime errors.

### 2. **Auto-completion**
IDE provides intelligent code completion.

### 3. **Single Source of Truth**
All request/response structures are defined in one place.

### 4. **Easy Testing**
DTOs can be easily instantiated and tested.

### 5. **Documentation Self-contained**
Each DTO serves as documentation for API contracts.

### 6. **Immutability**
`copyWith` methods enable immutable updates.

## Usage Examples

### Login Request

```dart
import 'package:pos/features/auth/data/dtos/dtos.dart';

// Create login request
final request = LoginRequest(
  username: 'user@example.com',
  password: 'password123',
);

// Convert to JSON for API
final result = await apiClient.post(
  ApiEndpoints.login,
  data: request.toJson(),
);

// Parse response
final authResponse = AuthResponse.fromJson(result);

// Access data
print(authResponse.user.name);
print(authResponse.accessToken);
```

### Register Request

```dart
final request = RegisterRequest(
  name: 'John Doe',
  email: 'john@example.com',
  password: 'password123',
);

await apiClient.post(
  ApiEndpoints.register,
  data: request.toJson(),
);
```

### Refresh Token

```dart
// Create request from existing token
final request = RefreshTokenRequest.fromToken(refreshToken);

final response = await apiClient.post(
  ApiEndpoints.refresh,
  data: request.toJson(),
);

final refreshResponse = RefreshTokenResponse.fromJson(response);
```

## DTO Features

### All DTOs Include:

1. **`fromJson()`** - Factory constructor for parsing API responses
2. **`toJson()`** - Convert to JSON for API requests
3. **`copyWith()`** - Create modified copies (immutability pattern)
4. **`toString()`** - Human-readable string representation
5. **`==` & `hashCode`** - Value equality comparison

### Example: LoginRequest

```dart
class LoginRequest {
  final String username;
  final String password;

  LoginRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };

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
    return other is LoginRequest &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
```

## Integration with Clean Architecture

### Data Layer
```dart
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  Future<UserModel> login({required String username, required String password}) async {
    // Create request DTO
    final request = LoginRequest(
      username: username,
      password: password,
    );

    // API call with DTO
    final result = await _apiClient.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );

    // Parse response DTO
    final authResponse = AuthResponse.fromJson(result);

    // Extract and save tokens
    await _saveTokens(authResponse);

    // Return entity
    return authResponse.user.toEntity();
  }
}
```

### Domain Layer
```dart
// Domain layer only sees entities, not DTOs
class UserEntity {
  final String id;
  final String name;
  final String email;
  // ... domain-specific fields
}
```

### Presentation Layer
```dart
// Presentation layer consumes use cases, not DTOs
Future<void> login(String username, String password) async {
  final result = await _loginUseCase(
    LoginParams(username: username, password: password),
  );

  result.fold(
    (failure) => _showError(failure.message),
    (user) => _navigateToHome(user),
  );
}
```

## Best Practices

### 1. **Always Use DTOs**
Never pass raw Map<String, dynamic> to API calls.

### 2. **Validate in Use Cases**
Keep DTOs simple, validate business logic in use cases.

```dart
// ❌ Don't validate in DTO
class LoginRequest {
  LoginRequest({required String email}) {
    if (!email.contains('@')) {
      throw ArgumentError('Invalid email');
    }
  }
}

// ✅ Validate in use case
class LoginUseCase {
  Future<Either<Failure, UserEntity>> execute({
    required String email,
    required String password,
  }) {
    if (!_isValidEmail(email)) {
      return Future.value(Left(InputFailure('Invalid email format')));
    }
    // ... proceed
  }
}
```

### 3. **Sensitive Data in toString()**
Always mask sensitive fields like passwords and tokens.

```dart
@override
String toString() => 'LoginRequest(username: $username, password: ****)';
```

### 4. **Nullable Fields**
Handle optional fields gracefully.

```dart
class RefreshTokenResponse {
  final String accessToken;
  final String? refreshToken; // Optional field

  RefreshTokenResponse({
    required this.accessToken,
    this.refreshToken,
  });

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    if (refreshToken != null) 'refresh_token': refreshToken, // Conditional
  };
}
```

### 5. **Use Barrel Export**
Import all DTOs from a single file.

```dart
import 'package:pos/features/auth/data/dtos/dtos.dart';

// Now you can use all DTOs directly
LoginRequest(...)
AuthResponse(...)
RefreshTokenRequest(...)
```

## Testing DTOs

### Unit Test Example

```dart
void main() {
  group('LoginRequest', () {
    test('should convert to JSON correctly', () {
      final request = LoginRequest(
        username: 'user@example.com',
        password: 'password123',
      );

      final json = request.toJson();

      expect(json, {
        'username': 'user@example.com',
        'password': 'password123',
      });
    });

    test('should mask password in toString()', () {
      final request = LoginRequest(
        username: 'user@example.com',
        password: 'password123',
      );

      final str = request.toString();

      expect(str, contains('****'));
      expect(str, isNot(contains('password123')));
    });

    test('should copy with new values', () {
      final request = LoginRequest(
        username: 'user@example.com',
        password: 'password123',
      );

      final copied = request.copyWith(password: 'newpassword');

      expect(copied.username, 'user@example.com');
      expect(copied.password, 'newpassword');
    });
  });
}
```

## Common Patterns

### Request with Multiple Fields
```dart
class UpdateProfileRequest {
  final String? name;
  final String? email;
  final String? phone;

  UpdateProfileRequest({
    this.name,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
      };
}
```

### Nested Objects
```dart
class AddressRequest {
  final String street;
  final String city;
  final String country;

  AddressRequest({
    required this.street,
    required this.city,
    required this.country,
  });

  Map<String, dynamic> toJson() => {
        'street': street,
        'city': city,
        'country': country,
      };
}

class RegisterWithAddressRequest {
  final String name;
  final String email;
  final String password;
  final AddressRequest address;

  RegisterWithAddressRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'address': address.toJson(),
      };
}
```

## Migration Guide

### From Manual Maps to DTOs

**Before:**
```dart
final result = await _apiClient.post('/auth/login',
  data: {
    'username': username,
    'password': password,
  },
);

final user = UserModel.fromJson(response['user']);
final token = response['access_token'];
```

**After:**
```dart
final request = LoginRequest(
  username: username,
  password: password,
);

final result = await _apiClient.post(
  ApiEndpoints.login,
  data: request.toJson(),
);

final authResponse = AuthResponse.fromJson(result);
final user = authResponse.user;
final token = authResponse.accessToken;
```

## Additional Resources

- [Clean Architecture Guide](../../../core/generators/ARCHITECTURE_GUIDE.md)
- [API Endpoints](../../../core/network/api_endpoints.dart)
- [ApiClient Documentation](../../../core/network/api_client.dart)
