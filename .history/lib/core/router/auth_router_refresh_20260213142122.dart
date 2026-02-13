import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/auth/providers/auth_state_provider.dart';

class AuthListenable extends ChangeNotifier {
  AuthListenable(this.ref) {
    ref.listen(authProvider, (_, _) {
      notifyListeners();
    });
  }

  final Ref ref;
}