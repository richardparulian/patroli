import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/presentation/controllers/check_in_controller.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  const CheckInScreen({super.key});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> {
  File? _selfieImage;
  bool _isCameraInitialized = false;
  bool _isSubmitting = false;
  
  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.request();
    
    if (status.isGranted) {
      _isCameraInitialized = true;
      setState(() {});
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

  Future<void> _takeSelfie() async {
    if (_isSubmitting) return;
    
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.front,
      );
      
      if (image != null) return;
      
      _selfieImage = File(image!.path);
      setState(() {});
    } on Exception catch (e) {
      if (mounted) {
        AppDialog.showError(
          context: context,
          title: 'Gagal Mengambil Foto',
          message: e.toString(),
        );
      }
    }
  }

  Future<void> _removeSelfie() async {
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
            blurRadius: 20,
            offset: const Offset(0, 4),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary.withValues(alpha: 0.1),
                ),
                child: Icon(Icons.camera_alt_outlined, size: 24, color: colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Foto Selfie Check-In',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Ambil foto selfie untuk konfirmasi kehadiran',
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
          
          // Photo Preview / Placeholder
          Container(
            width: 200,
            height: 250,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 2,
                color: colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: _selfieImage != null ? Stack(
                children: [
                  Image.file(_selfieImage!, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
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
                        child: Icon(Icons.close, size: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ) : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_outlined, size: 64, color: colorScheme.onSurface.withValues(alpha: 0.3)),
                    const SizedBox(height: 12),
                    Text('Belum ada foto',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (!_isCameraInitialized)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.block_outlined,
                              size: 16,
                              color: colorScheme.error,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Izin kamera diperlukan',
                              style: TextStyle(
                                color: colorScheme.error,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Take Photo Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: _isSubmitting ? null : _takeSelfie,
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

    if (branchData == null) return const SizedBox.shrink();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Konfirmasi Check-In',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: 18,
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Silakan melakukan foto selfie untuk konfirmasi kehadiran',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ]
        ),
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
                _buildInfoCard(
                  icon: Icons.store,
                  title: 'Nama Cabang',
                  value: branchData.name,
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

          if (_selfieImage != null && !_isSubmitting) ...[
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting? null : () => _submitCheckIn(branchData),
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
          ],
        ],
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String title, required String? value}) {
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
                Text(title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(value ?? '-',
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
}
