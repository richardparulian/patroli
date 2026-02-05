import 'package:flutter_test/flutter_test.dart';
import 'package:pos/features/auth/data/dtos/login_request.dart';

void main() {
  group('LoginRequest', () {
    const username = 'user@example.com';
    const password = 'password123';

    test('should create instance with valid parameters', () {
      // Arrange & Act
      final request = LoginRequest(
        username: username,
        password: password,
      );

      // Assert
      expect(request.username, username);
      expect(request.password, password);
    });

    test('should convert to JSON correctly', () {
      // Arrange
      final request = LoginRequest(
        username: username,
        password: password,
      );

      // Act
      final json = request.toJson();

      // Assert
      expect(json, isA<Map<String, dynamic>>());
      expect(json['username'], username);
      expect(json['password'], password);
    });

    test('should mask password in toString()', () {
      // Arrange
      final request = LoginRequest(
        username: username,
        password: password,
      );

      // Act
      final str = request.toString();

      // Assert
      expect(str, contains('LoginRequest'));
      expect(str, contains(username));
      expect(str, contains('****')); // Password should be masked
      expect(str, isNot(contains(password))); // Password should not be visible
    });

    test('should copy with new values', () {
      // Arrange
      final request = LoginRequest(
        username: username,
        password: password,
      );

      // Act
      final copied = request.copyWith(
        username: 'new@example.com',
        password: 'newpassword',
      );

      // Assert
      expect(copied.username, 'new@example.com');
      expect(copied.password, 'newpassword');
      expect(request.username, username); // Original should not change
      expect(request.password, password); // Original should not change
    });

    test('should copy with null values (keep original)', () {
      // Arrange
      final request = LoginRequest(
        username: username,
        password: password,
      );

      // Act
      final copied = request.copyWith(
        username: null,
        password: null,
      );

      // Assert
      expect(copied.username, username); // Should keep original
      expect(copied.password, password); // Should keep original
    });

    test('should copy with only username changed', () {
      // Arrange
      final request = LoginRequest(
        username: username,
        password: password,
      );

      // Act
      final copied = request.copyWith(username: 'changed@example.com');

      // Assert
      expect(copied.username, 'changed@example.com');
      expect(copied.password, password); // Should keep original password
    });

    test('should implement equality correctly', () {
      // Arrange
      final request1 = LoginRequest(
        username: username,
        password: password,
      );

      final request2 = LoginRequest(
        username: username,
        password: password,
      );

      final request3 = LoginRequest(
        username: 'different@example.com',
        password: password,
      );

      // Assert
      expect(request1, equals(request2)); // Same values
      expect(request1, isNot(equals(request3))); // Different username
      expect(request2, isNot(equals(request3))); // Different username
    });

    test('should be equal to itself', () {
      // Arrange
      final request = LoginRequest(
        username: username,
        password: password,
      );

      // Assert
      expect(request, equals(request));
    });

    test('should have correct hashCode', () {
      // Arrange
      final request1 = LoginRequest(
        username: username,
        password: password,
      );

      final request2 = LoginRequest(
        username: username,
        password: password,
      );

      // Assert
      expect(request1.hashCode, equals(request2.hashCode));
    });

    test('should handle empty strings', () {
      // Arrange & Act
      final request = LoginRequest(
        username: '',
        password: '',
      );

      // Assert
      expect(request.username, '');
      expect(request.password, '');

      final json = request.toJson();
      expect(json['username'], '');
      expect(json['password'], '');
    });

    test('should handle special characters', () {
      // Arrange & Act
      final request = LoginRequest(
        username: 'user+test@example.co.uk',
        password: 'p@ssw0rd!#\$%',
      );

      // Assert
      expect(request.username, 'user+test@example.co.uk');
      expect(request.password, 'p@ssw0rd!#\$%');

      final json = request.toJson();
      expect(json['username'], 'user+test@example.co.uk');
      expect(json['password'], 'p@ssw0rd!#\$%');
    });
  });
}
