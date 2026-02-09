// TODO: Implement Cache Auth Providers
//
// This file is reserved for future implementation of caching layer providers.
// Currently, all repositories use direct implementation without caching.
//
// Purpose of this implementation:
// - Provide dependency injection for cached repositories
// - Separate local and remote repository providers
// - Allow easy switching between cached and non-cached implementations
//
// Architecture Pattern: Provider Override Pattern
//
// Implementation Guide:
//
// 1. Implement CachedUserRepository in cached_user_repository_impl.dart first
//
// 2. Create provider for local repository (using SharedPreferences, Hive, etc.):
//    ```dart
//    import 'package:flutter_riverpod/flutter_riverpod.dart';
//    import 'package:pos/features/auth/data/repositories/auth_repository_impl.dart';
//    import 'package:pos/core/storage/cache_service.dart'; // TODO: create this
//
//    // :: Local repository provider (for caching)
//    final localAuthRepositoryProvider = Provider<AuthRepository>((ref) {
//      return AuthRepositoryImpl(
//        remoteDataSource: ref.watch(localDataSourceProvider),
//        localStorageService: ref.watch(localStorageServiceProvider),
//        secureStorageService: ref.watch(secureStorageServiceProvider),
//      );
//    });
//
//    // :: Local data source provider
//    final localDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
//      // Implement local data source that reads from cache
//      // Or remove this if using AuthRepositoryImpl with local storage
//      throw UnimplementedError('Local data source not implemented yet');
//    });
//    ```
//
// 3. Create provider for cached repository (combining local + remote):
//    ```dart
//    import 'package:pos/features/auth/data/repositories/cached_user_repository_impl.dart';
//    import 'package:pos/features/auth/presentation/providers/auth_use_case_provider.dart';
//
//    // :: Cached repository provider (local + remote)
//    final cachedAuthRepositoryProvider = Provider<AuthRepository>((ref) {
//      return CachedUserRepositoryImpl(
//        localRepository: ref.watch(localAuthRepositoryProvider),
//        remoteRepository: ref.watch(authRepositoryProvider),
//      );
//    });
//    ```
//
// 4. Override default auth repository with cached version:
//    ```dart
//    import 'package:pos/features/auth/domain/repositories/auth_repository.dart';
//
//    // :: Override auth repository to use cached version
//    final authRepositoryProviderOverride = Provider<AuthRepository>((ref) {
//      return ref.watch(cachedAuthRepositoryProvider);
//    });
//
//    // Or use ProviderFamily for different implementations:
//    final authRepositoryProvider = Provider.family<AuthRepository, bool>((ref, useCache) {
//      if (useCache) {
//        return ref.watch(cachedAuthRepositoryProvider);
//      }
//      return ref.watch(authRepositoryProvider);
//    });
//    ```
//
// 5. Export providers for use in the app:
//    ```dart
//    // Export all cache-related providers
//    export 'localAuthRepositoryProvider.dart';
//    export 'cachedAuthRepositoryProvider.dart';
//    ```
//
// 6. Update app providers to use cached version:
//    ```dart
//    // In lib/main.dart or providers.dart
//    import 'package:pos/features/auth/providers/cache_auth_providers.dart';
//
//    // Use cached repository instead of direct implementation
//    final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
//      return LoginUseCase(
//        ref.watch(authRepositoryProviderOverride), // Use cached version
//      );
//    });
//    ```
//
// Provider Hierarchy:
// ```
// authRepositoryProviderOverride (cached version)
//         ↓
// cachedAuthRepositoryProvider (local + remote)
//         ↓          ↓
// localAuthRepository  remoteAuthRepository
//    (cache/storage)       (API)
// ```
//
// Benefits of this implementation:
//    ✅ Flexible - Easy to enable/disable caching per environment
//    ✅ Testable - Can mock local and remote separately
//    ✅ Maintainable - Clear separation of concerns
//    ✅ Scalable - Easy to add more caching strategies
//
// Usage Example:
//    ```dart
//    // In your widget or service
//    final authRepo = ref.watch(authRepositoryProviderOverride);
//    final user = await authRepo.getCurrentUser(); // Checks cache first
//    ```
//
// Note: Ensure to:
// - Test caching behavior thoroughly
// - Handle cache invalidation
// - Monitor cache hit/miss ratios
// - Consider cache expiration policies
// - Implement cache warming for frequently accessed data
//
// References:
// - Riverpod Providers: https://riverpod.dev/docs/concepts/providers
// - Provider Override: https://riverpod.dev/docs/concepts/overrides
//
// Current Status: Not implemented (file reserved for future use)
