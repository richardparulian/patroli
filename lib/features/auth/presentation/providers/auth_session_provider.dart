import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/auth/domain/entities/user_entity.dart';

class AuthSessionNotifier extends Notifier<UserEntity?> {
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

final authSessionProvider = NotifierProvider<AuthSessionNotifier, UserEntity?>(AuthSessionNotifier.new);