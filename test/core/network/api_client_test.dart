import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/network/api_client.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late ApiClient apiClient;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    apiClient = ApiClient(mockDio);
  });

  group('ApiClient', () {
    const tPath = '/test';
    final tResponseData = {'success': true};

    test('get should perform a GET request and return Right(data)', () async {
      // Arrange
      final response = MockResponse();
      when(() => response.data).thenReturn(tResponseData);
      when(() => response.statusCode).thenReturn(200);
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => response);

      // Act
      final result = await apiClient.get(tPath);

      // Assert
      verify(() => mockDio.get(tPath));
      expect(result, Right(tResponseData));
    });

    test(
      'get should return Left(ServerFailure) when DioException occurs',
      () async {
        // Arrange
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: tPath),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(path: tPath),
              statusCode: 500,
              data: {'message': 'Server Error'},
            ),
          ),
        );

        // Act
        final result = await apiClient.get(tPath);

        // Assert
        expect(result, isA<Left<Failure, dynamic>>());
        result.fold(
          (failure) => expect(failure, isA<ServerFailure>()),
          (_) => fail('Should have returned Left'),
        );
      },
    );

    test(
      'get should return Left(NetworkFailure) for HttpException unknown errors without leaking raw URI details',
      () async {
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: tPath),
            type: DioExceptionType.unknown,
            error: HttpException(
              'Connection closed before full header was received',
              uri: Uri.parse('https://example.com/secret/path'),
            ),
          ),
        );

        final result = await apiClient.get(tPath);

        expect(result, isA<Left<Failure, dynamic>>());
        result.fold((failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, 'Tidak ada koneksi internet');
          expect(failure.message.contains('example.com'), isFalse);
        }, (_) => fail('Should have returned Left'));
      },
    );
  });
}
