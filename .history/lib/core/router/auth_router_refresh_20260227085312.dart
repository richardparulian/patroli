import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/auth/domain/entities/user_entity.dart';
import 'package:pos/features/auth/presentation/controllers/auth_controller.dart';

class AuthListenable extends ChangeNotifier {
  // AuthListenable(this.ref) {
  //   ref.listen(authProvider, (_, _) => notifyListeners());
  // }
  AuthListenable(this.ref) {
    ref.listen<AsyncValue<UserEntity?>>(authProvider, (previous, next) {
      final wasLoggedIn = previous?.asData?.value != null;
      final isLoggedIn = next.asData?.value != null;

      if (wasLoggedIn != isLoggedIn) {
        notifyListeners();
      }
    });
  }

  final Ref ref;
}