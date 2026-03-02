import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/auth/presentation/providers/auth_session_provider.dart';

class AuthListenable extends ChangeNotifier {
  AuthListenable(this.ref) {
    ref.listen(authSessionProvider, (_, __) => notifyListeners());
  }

  final Ref ref;
}