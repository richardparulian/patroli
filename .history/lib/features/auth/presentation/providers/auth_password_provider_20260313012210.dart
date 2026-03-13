import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPasswordNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void show() => state = true;
  void hide() => state = false;
}

final authPasswordProvider = NotifierProvider<AuthPasswordNotifier, bool>(AuthPasswordNotifier.new);