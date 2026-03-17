import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:patroli/core/utils/screen_util.dart';
import 'package:patroli/features/auth/presentation/screens/login_screen.dart';

void main() {
  testGoldens('LoginScreen golden test', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [Device.phone, Device.iphone11, Device.tabletPortrait],
      )
      ..addScenario(
        widget: ProviderScope(
          child: Builder(
            builder: (context) {
              ScreenUtil.init(context);

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
                home: const LoginScreen(),
              );
            },
          ),
        ),
        name: 'default_login_state',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'login_screen');
  });
}
