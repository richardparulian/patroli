import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';

class ImageRouteArgs {
  final String? imageUrl;
  final String? title;

  const ImageRouteArgs({
    this.imageUrl,
    this.title,
  });
}