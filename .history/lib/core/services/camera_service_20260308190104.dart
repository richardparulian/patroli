import 'package:camera/camera.dart';

class CameraService {
  static List<CameraDescription>? _cachedCameras;

  static Future<List<CameraDescription>> getCameras() async {
    _cachedCameras ??= await availableCameras();
    return _cachedCameras!;
  }
}