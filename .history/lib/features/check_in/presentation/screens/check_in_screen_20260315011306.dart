import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ntp/ntp.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/entities/visit_global_entity.dart';
import 'package:pos/core/enums/alert_type.dart';
import 'package:pos/core/extensions/helper_state_extension.dart';
import 'package:pos/core/extensions/pre_sign_extension.dart';
import 'package:pos/core/providers/camera_provider.dart';
import 'package:pos/core/services/camera_service.dart';
import 'package:pos/core/services/permission_service.dart';
import 'package:pos/core/ui/buttons/app_icon_button.dart';
import 'package:pos/core/ui/cards/app_card_alert.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/core/ui/widgets/app_loading.dart';
import 'package:pos/features/check_in/presentation/providers/check_in_provider.dart';
import 'package:pos/features/check_in/presentation/providers/upload_file_provider.dart';
import 'package:pos/features/reports/providers/reports_refresh_coordinator_provider.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:uuid/uuid.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  final ScanQrEntity? scanQrData;

  const CheckInScreen({super.key, this.scanQrData});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> with SingleTickerProviderStateMixin {
  XFile? _selfieImage;
  CameraController? _cameraController;

  final double _mirror = 1.0;

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 300));
      await _initCamera();
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _cameraController = null;
  
    _animationController.dispose();

    super.dispose();
  }

  Future<void> _initCamera() async {
    final notifier = ref.read(cameraProvider.notifier);

    notifier.setInitializing(true);

    await Future.delayed(const Duration(milliseconds: 1000));

    try {
      if (!mounted) return;
      final hasPermission = await PermissionService.checkAndRequestCameraPermission(
        context: context,
      );

      if (!hasPermission) return;

      final frontCamera = await CameraService.getFrontCamera();

      final controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await controller.initialize();
      await controller.setFocusMode(FocusMode.auto);

      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() => _cameraController = controller);

      ref.read(cameraProvider.notifier).setInitializing(false);
    } catch (e) {
      ref.read(cameraProvider.notifier).setInitializing(false);

      if (!mounted) return;
      AppDialog.showError(
        context: context,
        title: 'Gagal',
        message: e.toString(),
        buttonText: 'Coba Lagi',
        onButtonPressed: () async => await _initCamera(),
      );
    }
  }

  Future<void> _onCapture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized || _cameraController!.value.isTakingPicture) {
      return;
    }

    await _animationController.forward();
    await _animationController.reverse();

    final image = await _cameraController!.takePicture();

    setState(() => _selfieImage = image);

    final notifier = ref.read(uploadFileProvider.notifier);

    notifier.setLoading(); 

    if (!mounted) return;

    final uuid = const Uuid().v4();

    DateTime now;

    try {
      now = await NTP.now();
    } catch (_) {
      now = DateTime.now();
    }

    final filename = '${uuid}_${now.millisecondsSinceEpoch}.jpg';

    if (!mounted) return;
    final scanQrData = GoRouterState.of(context).extra as ScanQrEntity?;

    await notifier.runCheckIn(
      image: image,
      filename: filename,
      branchId: scanQrData?.id ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final isLoadingUploadFile = ref.watch(uploadFileProvider.select((s) => s.isLoading));
    final isLoadingCheckIn = ref.watch(checkInProvider.select((s) => s.isLoading));

    ref.listen(uploadFileProvider, (prev, next) {
      next.when(
        idle: () => null,
        loading: () {
          _cameraController?.pausePreview();
        },
        success: (value) {
          _cameraController?.resumePreview();
        },
        error: (msg) {
          _cameraController?.resumePreview();

          AppDialog.showError(
            context: context,
            title: 'Gagal',
            message: msg,
          );
        },
      );
    });

    ref.listen(checkInProvider, (prev, next) {
      next.when(
        idle: () => null,
        loading: () => null,
        success: (value) {
          if (!mounted) return;
          AppDialog.showSuccess(
            context: context,
            title: 'Berhasil',
            message: 'Konfirmasi kunjungan berhasil, silahkan lanjut ke proses berikutnya',
            buttonText: 'Lanjut',
            barrierDismissible: false,
            onButtonPressed: () async {
              await ref.read(reportsRefreshCoordinatorProvider).refreshReportsAndDashboard();
              if (!context.mounted) return;
              context.pushReplacement(AppConstants.visitRoute, extra: VisitRouteArgs(
                scanQr: widget.scanQrData,
                checkIn: value,
              ));
            },
          );
        },
        error: (msg) {
          _cameraController?.resumePreview();

          if (!mounted) return;
          AppDialog.showError(
            context: context,
            title: 'Gagal',
            message: msg,
          );
        },
      );
    });

    if (widget.scanQrData == null) {
      return _buildErrorWidget();
    }

    final isInitialized = _cameraController?.value.isInitialized ?? false;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // Prevent back if loading
          if (isLoadingUploadFile || isLoadingCheckIn) return;

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
          backgroundColor: color.surface,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Konfirmasi Masuk',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 18,
                  color: color.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Silakan melakukan foto selfie untuk konfirmasi kunjungan',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  color: color.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ]
          ),
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () {
              // Prevent back if loading
              if (isLoadingUploadFile || isLoadingCheckIn) return;

              AppDialog.showConfirm(
                context: context,
                title: 'Konfirmasi',
                message: 'Apakah Anda yakin ingin meninggalkan halaman ini?',
                onConfirm: () => context.go(AppConstants.homeRoute),
              );
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: Container(
              color: color.surface,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: AppAlertCard(
                title: 'Cabang',
                message: widget.scanQrData?.name ?? '---',
                type: AlertType.custom,
                customIcon: Icons.store,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              bottom: isInitialized ? 140 * 2 : 0,
              child: _buildSelfieSection(),
            ),

            if (isInitialized) ...[
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildButtonBottom(widget.scanQrData!),
              ),
            ],

            // // Loading overlay
            if (isLoadingUploadFile || isLoadingCheckIn) ...[
              AppLoading(message: isLoadingUploadFile ? 'Memproses foto selfie...' : 'Memproses kunjungan...'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.surface,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: color.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Icon(Iconsax.shop, size: 48, color: color.primary),
        ),
        const SizedBox(height: 16),
        Text('Data cabang tidak ditemukan',
          style: theme.textTheme.titleMedium?.copyWith(
            color: color.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        AppIconButton(
          onPressed: () => context.go(AppConstants.homeRoute),
          label: 'Kembali ke Beranda',
          icon: Icon(Iconsax.home),
          type: IconButtonType.primary,
        )
      ],
    );
  }

  Widget _buildSelfieSection() {
    final isCameraReady = ref.watch(cameraProvider.select((s) => s.isInitializing));
    final isInitialized = _cameraController?.value.isInitialized ?? false;

    if (isCameraReady) {
      return AppLoading(message: 'Mempersiapkan kamera...');
    }

    if (!isInitialized) const SizedBox.shrink();

    final previewSize = _cameraController?.value.previewSize;

    if (previewSize == null) {
      return const SizedBox.shrink();
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _cameraController?.value.previewSize!.height ?? 0,
          height: _cameraController?.value.previewSize!.width ?? 0,
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
  }

  Widget _buildButtonBottom(ScanQrEntity scanQrData) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final checkIn = ref.watch(checkInProvider);

    final presignUrl = ref.watch(uploadFileProvider).presign?.fileUrl;
    
    return _selfieImage == null ? GestureDetector(
      onTap: checkIn.isLoading ? null : () async => await _onCapture(),
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
              color: color.onSurface,
            ),
          ),
          child: Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.onSurface,
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
              onPressed: () {
                ref.read(checkInProvider.notifier).callCheckIn(
                  branchId: scanQrData.id ?? 0,
                  imageUrl: presignUrl ?? '',
                );
              },
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
