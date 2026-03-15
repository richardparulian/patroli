import 'package:pos/features/auth/domain/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_provider.g.dart';

@riverpod
class AuthSession extends _$AuthSession {
  @override
  UserEntity? build() {
    return null;
  }

  void setUser(UserEntity? user) {
    state = user;
  }
}

final authSessionProvider = NotifierProvider<AuthSessionNotifier, UserEntity?>(AuthSessionNotifier.new);