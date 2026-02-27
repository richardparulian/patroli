// Export theme mode provider for features
// Allows accessing themeModeProvider from main.dart

import 'package:pos/main.dart' show main;

// Re-export theme mode provider for use in features
final themeModeProvider = main.themeModeProvider;
