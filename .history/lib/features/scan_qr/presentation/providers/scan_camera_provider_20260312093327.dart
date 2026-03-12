import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_provider.dart';

class ScanQrState {
  final bool isTorchOn;
  final bool isProcessing;

  const ScanQrState({
    this.isTorchOn = false,
    this.isProcessing = false,
  });

  ScanQrState copyWith({
    bool? isTorchOn, 
    bool? isProcessing, 
  }) {
    return ScanQrState(
      isTorchOn: isTorchOn ?? this.isTorchOn,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

class ScanCameraNotifier extends Notifier<ScanQrState> {
  MobileScannerController? _controller;
  
  @override
  ScanQrState build() {
    return const ScanQrState();
  }

  void setController(MobileScannerController controller) {
    _controller = controller;
  }

  Future<void> pauseScanner() async {
    await _controller?.pause();
  }

  Future<void> startScanner() async {
    await _controller?.start();
  }

  void setProcessing(bool isProcessing) {
    state = state.copyWith(isProcessing: isProcessing);
  }

  Future<void> toggleTorch() async {
    if (_controller == null) return;

    await _controller?.toggleTorch();
    state = state.copyWith(isTorchOn: !state.isTorchOn);
  }

  Future<void> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    final result = await _controller?.analyzeImage(image.path);

    if (result != null && result.barcodes.isNotEmpty) {
      final barcode = result.barcodes.first;
      final qrCode = barcode.rawValue ?? barcode.displayValue ?? '';

      await _onScanned(qrCode);
    } else {
      final notifier = ref.read(scanQrProvider.notifier);

      notifier.setError(message: 'Kode QR tidak ditemukan pada gambar!');
    }
  }

  Future<void> _onScanned(String qrCode) async {
    final camera = ref.read(scanCameraProvider.notifier);
    final scanQr = ref.read(scanQrProvider.notifier);

    await camera.pauseScanner();
    
    await scanQr.runScanQr(qrCode);
  }
}

final scanCameraProvider = NotifierProvider<ScanCameraNotifier, ScanQrState>(ScanCameraNotifier.new);