import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  const CheckInScreen({super.key});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> {
  @override
  Widget build(BuildContext context) {
    final scanQrEntity = GoRouterState.of(context).extra as ScanQrEntity?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckIn'),
      ),
      body: Center(
        child: scanQrEntity != null ? Column(
          children: [
            Text('Branch: ${scanQrEntity.name}'),
            Text('QR Code: ${scanQrEntity.qrcode}'),
            // Tampilkan data lainnya
          ],
        ) : const Text('No data received'),
      ),
    );
  }
}
