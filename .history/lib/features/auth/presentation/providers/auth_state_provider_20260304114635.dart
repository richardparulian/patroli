import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordVisibilityProvider = NotifierProvider.autoDispose<_PasswordVisibilityNotifier, bool>(_PasswordVisibilityNotifier.new);

class _PasswordVisibilityNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void show() => state = true;
  void hide() => state = false;
}