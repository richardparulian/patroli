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
import 'package:pos/core/ui/buttons/app_button.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/presentation/controllers/check_in_controller.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_create_entity.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_create_controller.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_update_controller.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:uuid/uuid.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  const CheckInScreen({super.key});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> with SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final double _mirror = 1.0;
  
  XFile? _selfieImage;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 300));
      _initCamera();
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (_cameraController != null) {
      _cameraController!.dispose();
    }
    _cameraController = null;

    super.dispose();
  }

  void _showError(String message) {
    if (!mounted) return;
    AppDialog.showError(
      context: context,
      title: 'Gagal',
      message: message,
    );
  }

  Future<void> _initCamera() async {
    final hasPermission = await PermissionService.checkAndRequestCameraPermission(
      context: context,
    );

    if (!hasPermission) return;

    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front), ResolutionPreset.high, enableAudio: false);

    await _cameraController?.initialize();

    if (!mounted) return;
    setState(() {});
  }

  Future<void> _onCapture() async {
    await _animationController.forward();
    await _animationController.reverse();

    final image = await _cameraController?.takePicture();

    if (image == null) {
      _showError('Gagal mengambil foto');
      return;
    }

    setState(() => _selfieImage = image);

    final uuid = const Uuid().v4();

    DateTime ntpTime;

    try {
      ntpTime = await NTP.now();
    } catch (e) {
      ntpTime = DateTime.now();
      debugPrint('NTP failed, using local time: $e');
    }

    final userSession = ref.watch(authSessionProvider);
    final preSignController = ref.read(preSignCreateProvider.notifier);

    final uniqueFilename = '${userSession?.name ?? uuid}_${ntpTime.toLocal().millisecondsSinceEpoch}.jpg';
    await preSignController.createPreSign(
      request: PreSignCreateRequest(filename: uniqueFilename),
    );

    final preSignState = ref.read(preSignCreateProvider);

    if (preSignState.hasError) {
      final error = preSignState.error;
      _showError('Gagal mendapatkan URL upload: ${error?.toString() ?? "Unknown error"}');
      return;
    }
  
    if (preSignState.hasValue && preSignState.value != null) {
      final preSignEntity = preSignState.value!;
      
      await _handleUploadAndCheckIn(preSignEntity, image);
    }
  }

  Future<void> _uploadImage(XFile image, String uploadUrl) async {
    final preSignController = ref.read(preSignUpdateProvider.notifier);

    await preSignController.updatePreSign(url: uploadUrl, image: image);

    final preSignState = ref.read(preSignUpdateProvider);

    if (preSignState.hasValue && preSignState.value != null) {
      final preSignEntity = preSignState.value?.data;
      
      debugPrint('preSignEntity put: $preSignEntity');
    }
  }

  Future<void> _handleUploadAndCheckIn(PreSignCreateEntity preSignEntity, XFile image) async {
    try {
      await _uploadImage(image, preSignEntity.url);
      
      if (!mounted) return;
      final branchData = GoRouterState.of(context).extra as ScanQrEntity;
      final checkInRequest = CheckInRequest(
        branchId: branchData.id ?? 0,
        selfieCheckIn: preSignEntity.fileUrl,
      );

      await ref.read(checkInProvider.notifier).checkIn(request: checkInRequest);
      
      if (!mounted) return;
      AppDialog.showSuccess(
        context: context,
        title: 'Berhasil',
        message: 'Check-in berhasil! Silakan lanjutkan dengan mengisi form kondisi cabang.',
        buttonText: 'Oke',
        onButtonPressed: null,
      );
    } catch (e) {
      if (!mounted) return;
      AppDialog.showError(
        context: context,
        title: 'Gagal',
        message: 'Terjadi kesalahan: ${e.toString()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final padding = MediaQuery.of(context).padding;
    final branchData = GoRouterState.of(context).extra as ScanQrEntity?;

    if (branchData == null) return const SizedBox.shrink();

    debugPrint('padding: $kBottomNavigationBarHeight');

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
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
          ],
        ),
      ),
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
    if (!isInitialized) return const SizedBox.shrink();

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _cameraController!.value.previewSize!.height,
          height: _cameraController!.value.previewSize!.width,
          child: _selfieImage != null ? Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateY(_mirror == 1.0 ? math.pi : 0),
            child: Image.file(File(_selfieImage!.path)),
          ) : CameraPreview(_cameraController!),
        ),
      ),
    );
  }

  Widget _buildButton(ScanQrEntity branchData) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return _selfieImage == null ? GestureDetector(
      onTap: () async => await _onCapture(),
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
            child: AppButton(
              onPressed: () => setState(() => _selfieImage = null),
              label: 'Foto Ulang',
              type: ButtonType.outlined,
              icon: const Icon(Iconsax.camera5),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppButton(
              onPressed: () => setState(() => _selfieImage = null),
              label: 'Lanjutkan',
              icon: const Icon(Iconsax.next),
            ),
          ),
        ],
      ),
    );
  }
}
