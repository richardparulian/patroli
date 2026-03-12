import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';

class CheckInRouteArgs {
  final ScanQrEntity? scanQr; // optional
  final ReportsEntity? report; // optional

  const CheckInRouteArgs({
    this.scanQr,
    this.report,
  });
}