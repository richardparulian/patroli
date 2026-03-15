import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_password_provider.g.dart';

@riverpod
class AuthPassword extends _$AuthPassword {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void show() => state = true;
  void hide() => state = false;
}
