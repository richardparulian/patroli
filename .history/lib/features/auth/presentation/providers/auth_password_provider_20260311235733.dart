import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPasswordVisibilityNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void show() => state = true;
  void hide() => state = false;
}

final passwordVisibilityProvider = NotifierProvider.autoDispose<AuthPasswordVisibilityNotifier, bool>(AuthPasswordVisibilityNotifier.new);