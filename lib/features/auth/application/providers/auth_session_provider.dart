import 'package:patroli/features/auth/domain/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthSession extends _$AuthSession {
  @override
  UserEntity? build() {
    return null;
  }

  void setUser(UserEntity? user) {
    state = user;
  }

  void clear() {
    state = null;
  }
}
