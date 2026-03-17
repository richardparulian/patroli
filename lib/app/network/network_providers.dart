import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/network/interceptors/auth_interceptor.dart';
import 'package:patroli/core/providers/network_providers.dart';
import 'package:patroli/core/providers/storage_providers.dart';
import 'package:patroli/features/auth/application/services/auth_session_sync_provider.dart';

final dioWithAuthProvider = Provider.autoDispose<Dio>((ref) {
  final dio = ref.watch(dioProvider);
  final secureStorageService = ref.watch(secureStorageServiceProvider);

  dio.interceptors.removeWhere((interceptor) => interceptor is AuthInterceptor);
  dio.interceptors.add(
    AuthInterceptor(
      secureStorageService: secureStorageService,
      onUnauthorized: () async {
        await ref.read(authSessionSyncServiceProvider).forceLogout();
      },
    ),
  );

  return dio;
});
