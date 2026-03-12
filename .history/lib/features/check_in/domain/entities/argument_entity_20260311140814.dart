import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';

class CheckInRouteArgs {
  final ScanQrEntity? scanQr; // optional
  final CheckInEntity? checkIn; // optional

  const CheckInRouteArgs({
    this.scanQr,
    this.checkIn,
  });
}