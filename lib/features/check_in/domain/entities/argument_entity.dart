import 'package:patroli/features/check_in/domain/entities/check_in_entity.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';

class CheckInRouteArgs {
  final ScanQrEntity? scanQr; // optional
  final CheckInEntity? checkIn; 
  final ReportsEntity? report;

  const CheckInRouteArgs({
    this.scanQr,
    this.checkIn,
    this.report,
  });
}