import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ntp/ntp.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/services/permission_service.dart';
import 'package:pos/core/ui/buttons/app_icon_button.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/features/check_in/presentation/providers/check_in_state_provider.dart';
import 'package:pos/features/check_in/widgets/loading_overlay.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:uuid/uuid.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  const CheckInScreen({super.key});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> with SingleTickerProviderStateMixin {
  XFile? _selfieImage;
  CameraController? _cameraController;

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final ProviderSubscription<CheckInState> _checkInListener;

  final double _mirror = 1.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _checkInListener = ref.listenManual(checkInStateProvider, (prev, next) {
      if (next.isSuccess && mounted) { 
        AppDialog.showSuccess(
          context: context,
          title: 'Berhasil',
          message: 'Check-in berhasil! Silakan lanjutkan dengan mengisi form kondisi cabang.',
          buttonText: 'Oke',
          onButtonPressed: () {
            ref.read(checkInStateProvider.notifier).clear();
            // Navigate ke halaman berikutnya jika perlu
            // context.go(AppConstants.homeRoute);
          },
        );
      } else if (next.errorMessage != null && mounted) {  // Handle error
        AppDialog.showError(
          context: context,
          title: 'Gagal',
          message: next.errorMessage!,
          buttonText: 'Oke',
          onButtonPressed: () {
            ref.read(checkInStateProvider.notifier).clear();
          },
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      await _initCamera();
    });
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    _cameraController = null;
  
    _animationController.dispose();
    _checkInListener.close();

    super.dispose();
  }

  Future<void> _initCamera() async {
    try {
      final hasPermission = await PermissionService.checkAndRequestCameraPermission(
        context: context,
      );

      if (!hasPermission) return;

      final cameras = await availableCameras();

      if (cameras.isEmpty) return;

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(frontCamera, ResolutionPreset.high, enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);

      await _cameraController?.initialize();
      await _cameraController?.setFocusMode(FocusMode.auto);

      if (!mounted) return;
      setState(() {});
    } catch (e) {
      if (!mounted) return;
      AppDialog.showError(
        context: context,
        title: 'Gagal',
        message: e.toString(),
        buttonText: 'Oke',
      );
    }
  }

  Future<void> _onCapture() async {
    final notifier = ref.read(checkInStateProvider.notifier);

    if (_cameraController == null || !_cameraController!.value.isInitialized || _cameraController!.value.isTakingPicture) {
      return;
    }

    notifier.setLoading(true);

    await _animationController.forward();
      await _animationController.reverse();

      await Future.microtask(() {});
      final image = await _cameraController!.takePicture();

      setState(() => _selfieImage = image);

      if (!mounted) return;

      final branchData = GoRouterState.of(context).extra as ScanQrEntity;

      final uuid = const Uuid().v4();

      DateTime now;

      try {
        now = await NTP.now();
      } catch (_) {
        now = DateTime.now();
      }

      final filename = '${uuid}_${now.millisecondsSinceEpoch}.jpg';


      await notifier.runCheckIn(
        image: image,
        filename: filename,
        branchId: branchData.id ?? 0,
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final padding = MediaQuery.of(context).padding;

    final isLoading = ref.watch(checkInStateProvider.select((s) => s.isLoading));

    final branchData = GoRouterState.of(context).extra as ScanQrEntity?;

    if (branchData == null) {
      return _buildErrorWidget(Iconsax.shop, 'Data cabang tidak ditemukan', 'Kembali ke Beranda', Iconsax.home, () => context.go(AppConstants.homeRoute));
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // Prevent back if loading
          if (isLoading) return;

          AppDialog.showConfirm(
            context: context,
            title: 'Konfirmasi',
            message: 'Apakah Anda yakin ingin keluar dari halaman ini?',
            onConfirm: () => context.go(AppConstants.homeRoute),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: colorScheme.surface,
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
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () {
              // Prevent back if loading
              if (isLoading) return;

              AppDialog.showConfirm(
                context: context,
                title: 'Konfirmasi',
                message: 'Apakah Anda yakin ingin meninggalkan halaman ini?',
                onConfirm: () => context.go(AppConstants.homeRoute),
              );
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight + padding.bottom),
            child: Container(
              color: colorScheme.surface,
              child: _buildInfoCard(
                icon: Icons.store,
                title: 'Cabang',
                value: branchData.name,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              bottom: 140 * 2,
              child: _buildSelfieSection(branchData),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildButton(branchData),
            ),

            // Loading overlay
            if (isLoading) ...[
              // Container(
              //   color: Colors.black54,
              //   child: Center(
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         const CircularProgressIndicator(
              //           strokeWidth: 5,
              //           color: Colors.white,
              //           strokeCap: StrokeCap.round,
              //         ),
              //         const SizedBox(height: 16),
              //         Text(loadingMessage,
              //           style: const TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.w300,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const LoadingOverlay(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(IconData iconMessage, String message, String buttonText, IconData iconButton, VoidCallback onButtonPressed) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Icon(iconMessage, size: 48, color: colorScheme.primary),
        ),
        const SizedBox(height: 16),
        Text(message,
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        AppIconButton(
          onPressed: onButtonPressed,
          label: buttonText,
          icon: Icon(iconButton),
          type: IconButtonType.primary,
        )
      ],
    );
  }

  Widget _buildInfoCard({required IconData icon, required String title, required String? value}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(10),
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
        ),
      ],
    );
  }

  Widget _buildSelfieSection(ScanQrEntity branchData) {
    final isInitialized = _cameraController?.value.isInitialized ?? false;

    if (!isInitialized) {
      return const SizedBox.shrink();
      // return _buildErrorWidget(Iconsax.camera_slash, 'Kamera gagal diinisialisasi', 'Coba lagi', Iconsax.refresh, () async => await _initCamera());
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _cameraController?.value.previewSize!.height ?? 0,
          height: _cameraController?.value.previewSize!.width ?? 0,
          // child: _selfieImage != null ? Transform(
          //   alignment: Alignment.center,
          //   transform: Matrix4.identity()..rotateY(_mirror == 1.0 ? math.pi : 0),
          //   child: Image.file(File(_selfieImage!.path)),
          // ) : CameraPreview(_cameraController!),
          child: Stack(
          fit: StackFit.expand,
            children: [
              CameraPreview(_cameraController!),

              if (_selfieImage != null) ...[
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(_mirror == 1.0 ? math.pi : 0),
                  child: Image.file(
                    File(_selfieImage!.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
    // final size = MediaQuery.of(context).size;
    // final deviceRatio = size.width / size.height;
    // final previewRatio = _cameraController!.value.aspectRatio;

    // return ClipRect(
    //   child: OverflowBox(
    //     alignment: Alignment.center,
    //     maxHeight: deviceRatio > previewRatio ? size.width / previewRatio : size.height,
    //     maxWidth: deviceRatio > previewRatio ? size.width : size.height * previewRatio,
    //     child: CameraPreview(_cameraController!),
    //   ),
    // );
  }

  Widget _buildButton(ScanQrEntity branchData) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final checkInState = ref.watch(checkInStateProvider);
    
    return _selfieImage == null ? GestureDetector(
      onTap: checkInState.isLoading ? null : () async => await _onCapture(),
      child: AnimatedBuilder(
        animation: _scaleAnimation, 
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: 80,
          height: 80,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 4,
              color: colorScheme.onSurface,
            ),
          ),
          child: Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    ) : Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: AppIconButton(
              onPressed: () => setState(() => _selfieImage = null),
              label: 'Foto Ulang',
              type: IconButtonType.outlined,
              icon: const Icon(Iconsax.camera5),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppIconButton(
              onPressed: () => setState(() => _selfieImage = null),
              label: 'Lanjutkan',
              icon: const Icon(Iconsax.next),
              type: IconButtonType.primary,
            ),
          ),
        ],
      ),
    );
  }
}
