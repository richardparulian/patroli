import 'package:camera/camera.dart';

class CameraService {
  static List<CameraDescription>? _cachedCameras;

  static Future<List<CameraDescription>> getCameras() async {
    _cachedCameras ??= await availableCameras();
    return _cachedCameras!;
  }

  static Future<CameraDescription> getFrontCamera() async {
    final cameras = await getCameras();

    return cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front, orElse: () => cameras.first);
  }
}