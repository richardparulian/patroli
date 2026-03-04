import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/presentation/controllers/check_in_controller.dart';
import 'package:pos/features/check_in/presentation/providers/check_in_di_provider.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  const CheckInScreen({super.key});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> {
  CameraController? _controller;
  File? _selfieImage;
  bool _isCameraInitialized = false;
  bool _isCameraPermissionGranted = false;
  bool _isSubmitting = false;
  
  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.request();
    
    if (status.isGranted) {
      _isCameraPermissionGranted = true;
      setState(() {});
      _initializeCamera();
      return;
    }
    
    if (status.isPermanentlyDenied) {
      if (mounted) {
        AppDialog.showWarning(
          context: context,
          title: 'Izin Kamera Ditolak',
          message: 'Silakan buka pengaturan untuk mengaktifkan izin kamera',
          buttonText: 'Buka Pengaturan',
          barrierDismissible: false,
          onButtonPressed: () async {
            Navigator.of(context).pop();
            await openAppSettings();
          },
        );
      }
    }
  }

  Future<void> _initializeCamera() async {
    if (!_isCameraPermissionGranted) return;
    
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (mounted) {
          AppDialog.showError(
            context: context,
            title: 'Tidak Ada Kamera',
            message: 'Perangkat ini tidak memiliki kamera yang tersedia.',
          );
        }
        return;
      }

      // Pilih kamera depan (front camera)
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller!.initialize();
      
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } on CameraException catch (e) {
      if (mounted) {
        AppDialog.showError(
          context: context,
          title: 'Gagal Inisialisasi Kamera',
          message: e.description ?? e.toString(),
        );
      }
    }
  }

  Future<void> _takeSelfie() async {
    if (_isSubmitting) return;
    if (_controller == null || !_controller!.value.isInitialized) {
      AppDialog.showWarning(
        context: context,
        title: 'Kamera Belum Siap',
        message: 'Kamera belum siap. Mohon tunggu sebentar.',
      );
      return;
    }

    try {
      // Ambil gambar dari controller
      final image = await _controller!.takePicture();
      
      // Simpan gambar ke file
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/selfie_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await image.saveTo(path);
      
      _selfieImage = File(path);
      setState(() {});
    } on CameraException catch (e) {
      if (mounted) {
        AppDialog.showError(
          context: context,
          title: 'Gagal Mengambil Foto',
          message: e.description ?? e.toString(),
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        AppDialog.showError(
          context: context,
          title: 'Gagal Menyimpan Foto',
          message: e.toString(),
        );
      }
    }
  }

  Future<Directory> getTemporaryDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Android/data/com.example.app/cache');
    } else if (Platform.isIOS) {
      return Directory.systemTemp;
    }
    return Directory.systemTemp;
  }

  Future<void> _removeSelfie() async {
    try {
      if (_selfieImage != null && await _selfieImage!.exists()) {
        await _selfieImage!.delete();
      }
    } catch (e) {
      debugPrint('Error deleting selfie: $e');
    }
    
    setState(() {
      _selfieImage = null;
    });
  }

  Future<void> _submitCheckIn(ScanQrEntity branchData) async {
    if (_selfieImage == null) {
      AppDialog.showWarning(
        context: context,
        title: 'Foto Belum Diambil',
        message: 'Silakan ambil foto selfie terlebih dahulu.',
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final bytes = await _selfieImage!.readAsBytes();
      final base64Image = 'data:image/jpeg;base64,${base64Encode(bytes)}';

      final controller = ref.read(checkInProvider.notifier);
      await controller.checkIn(
        request: CheckInRequest(
          branchId: branchData.id ?? 0,
          selfieCheckIn: base64Image,
        ),
      );

      final state = ref.read(checkInProvider);
      state.when(
        data: (checkInEntity) {
          if (mounted) {
            AppDialog.showSuccess(
              context: context,
              title: 'Check-In Berhasil',
              message: 'Anda telah berhasil check-in di ${branchData.name}',
              onButtonPressed: () {
                context.pop();
                context.pop();
              },
            );
          }
        },
        loading: () {},
        error: (error, _) {
          if (mounted) {
            AppDialog.showError(
              context: context,
              title: 'Gagal Check-In',
              message: error.toString(),
              onButtonPressed: () {
                setState(() {
                  _isSubmitting = false;
                });
              },
            );
          }
        },
      );
    } on Exception catch (e) {
      if (mounted) {
        AppDialog.showError(
          context: context,
          title: 'Gagal Memproses Foto',
          message: e.toString(),
          onButtonPressed: () {
            setState(() {
              _isSubmitting = false;
            });
          },
        );
      }
    }
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String? value,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withValues(alpha: 0.1),
            ),
            child: Icon(icon, size: 24, color: colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value ?? '-',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelfieSection(ScanQrEntity branchData) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary.withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Foto Selfie Check-In',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Ambil foto selfie untuk konfirmasi kehadiran',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Camera Preview / Photo Display
          Container(
            width: 200,
            height: 250,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: _selfieImage != null
                  ? Stack(
                      children: [
                        Image.file(
                          _selfieImage!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: _removeSelfie,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withValues(alpha: 0.7),
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        // Camera Preview
                        if (_isCameraInitialized && _controller != null)
                          CameraPreview(_controller!),
                        
                        // Camera Permission Denied Message
                        if (!_isCameraPermissionGranted)
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.block_outlined,
                                  size: 64,
                                  color: colorScheme.error,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Izin kamera diperlukan',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.error,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton.icon(
                                  onPressed: _checkCameraPermission,
                                  icon: const Icon(Iconsax.refresh, size: 18),
                                  label: const Text('Izinkan'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        // Camera Loading
                        if (!_isCameraInitialized && _isCameraPermissionGranted)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        
                        // No Selfie Message
                        if (_isCameraInitialized)
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 64,
                                  color: colorScheme.onSurface.withValues(alpha: 0.3),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Belum ada foto',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                                  ),
                                ),
                              ],
                            ),
                      ),
                    ],
                  ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Take Photo Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: (_isSubmitting || !_isCameraInitialized) ? null : _takeSelfie,
              style: ElevatedButton.styleFrom(
                backgroundColor: _selfieImage != null ? colorScheme.primary : colorScheme.secondary,
                foregroundColor: _selfieImage != null ? colorScheme.onPrimary : colorScheme.onSecondary,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: _selfieImage != null
                  ? const Icon(Iconsax.camera, size: 22)
                  : const Icon(Iconsax.refresh, size: 22),
              label: Text(
                _selfieImage != null ? 'Ambil Foto' : 'Ambil Ulang',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final checkInState = ref.watch(checkInProvider);
    final branchData = GoRouterState.of(context).extra as ScanQrEntity?;

    if (branchData == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Check-In'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                'Data cabang tidak ditemukan',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Silakan scan QR code ulang',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Iconsax.arrow_left),
                label: const Text('Kembali'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-In'),
        elevation: 0,
        backgroundColor: colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                
                // Header
                Text(
                  'Konfirmasi Check-In',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Silakan lengkapi data check-in Anda',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Branch Info Cards
                _buildInfoCard(
                  icon: Icons.store,
                  title: 'Nama Cabang',
                  value: branchData.name,
                ),
                
                _buildInfoCard(
                  icon: Icons.qr_code,
                  title: 'QR Code',
                  value: branchData.qrcode ?? '-',
                ),
                
                if (branchData.kanitName != null)
                  _buildInfoCard(
                    icon: Icons.person_outline,
                    title: 'Kanit',
                    value: branchData.kanitName!,
                  ),
                
                if (branchData.kacabName != null)
                  _buildInfoCard(
                    icon: Icons.business_center_outlined,
                    title: 'Kacab',
                    value: branchData.kacabName!,
                  ),
                
                const SizedBox(height: 24),
                
                // Selfie Section
                _buildSelfieSection(branchData),
              ],
            ),
          ),
          
          // Loading Overlay
          if (_isSubmitting || checkInState.isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: colorScheme.primary,
                        strokeWidth: 3,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Memproses check-in...',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      
      // Submit Button (Floating)
      if (_selfieImage == null || _isSubmitting)
        const SizedBox.shrinked()
      else
        Positioned(
          bottom: 20,
          left: 16,
          right: 16,
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: _isSubmitting
                  ? null
                  : () => _submitCheckIn(branchData),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 8,
                shadowColor: colorScheme.primary.withValues(alpha: 0.3),
              ),
              icon: const Icon(Iconsax.send_1, size: 22),
              label: const Text(
                'Check-In Sekarang',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
    );
  }
}
