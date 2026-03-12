import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';

class CheckInRouteArgs {
  final ScanQrEntity scanQr;
  final ReportsEntity report;

  const CheckInRouteArgs({
    required this.scanQr,
    required this.report,
  });
}