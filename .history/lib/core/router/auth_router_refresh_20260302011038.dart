import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/auth/domain/entities/user_entity.dart';
import 'package:pos/features/auth/presentation/providers/auth_session_provider.dart';

class AuthListenable extends ChangeNotifier {
  AuthListenable(this.ref) {
    ref.listen<UserEntity?>(authSessionProvider, (previous, next) {
      final wasLoggedIn = previous != null;
      final isLoggedIn = next != null;

      if (wasLoggedIn != isLoggedIn) {
        notifyListeners();
      }
    });
  }

  final Ref ref;
}