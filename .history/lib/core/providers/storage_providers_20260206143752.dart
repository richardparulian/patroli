// Storage Providers
// Riverpod providers for storage-related services

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for SharedPreferences instance
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

/// Provider for LocalStorageService instance
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalStorageService(prefs);
});