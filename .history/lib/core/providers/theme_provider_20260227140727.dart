import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/main.dart';

// Theme mode provider wrapper for features
// Allows accessing themeModeProvider from main.dart

final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(main.themeModeProvider);
});
