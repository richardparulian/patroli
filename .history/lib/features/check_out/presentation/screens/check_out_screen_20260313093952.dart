import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ntp/ntp.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/enums/alert_type.dart';
import 'package:pos/core/extensions/helper_state_extension.dart';
import 'package:pos/core/providers/camera_provider.dart';
import 'package:pos/core/services/camera_service.dart';
import 'package:pos/core/services/permission_service.dart';
import 'package:pos/core/ui/buttons/app_icon_button.dart';
import 'package:pos/core/ui/cards/app_card_alert.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/core/ui/widgets/app_loading.dart';
import 'package:pos/features/check_out/presentation/providers/check_out_provider.dart';
import 'package:pos/features/reports/presentation/providers/reports_count_provider.dart';
import 'package:pos/features/reports/presentation/providers/reports_paging_provider.dart';
import 'package:uuid/uuid.dart';

class CheckOutScreen extends ConsumerStatefulWidget {
  final int? reportId;
  final int? branchId;
  final String? branchName;

  const CheckOutScreen({super.key, this.reportId, this.branchId, this.branchName});

  @override
  ConsumerState<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends ConsumerState<CheckOutScreen> with SingleTickerProviderStateMixin {
  XFile? _selfieImage;
  CameraController? _cameraController;

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  final double _mirror = 1.0;

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

    final notifier = ref.read(checkOutProvider.notifier);
    notifier.setLoading(); 

    await _animationController.forward();
    await _animationController.reverse();

    await Future.microtask(() {});
    final image = await _cameraController!.takePicture();

    setState(() => _selfieImage = image);

    if (!mounted) return;

    final uuid = const Uuid().v4();

    DateTime now;

    try {
      now = await NTP.now();
    } catch (_) {
      now = DateTime.now();
    }

    final filename = '${uuid}_${now.millisecondsSinceEpoch}.jpg';

    await notifier.runCheckOut(
      image: image,
      filename: filename,
      branchId: widget.branchId ?? 0,
      reportId: widget.reportId ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isLoading = ref.watch(checkOutProvider.select((s) => s.isLoading));

    if (widget.branchName?.isEmpty ?? true) {
      return _buildErrorWidget(Iconsax.shop, 'Data cabang tidak ditemukan', 'Kembali ke Beranda', Iconsax.home, () => context.go(AppConstants.homeRoute));
    }

    final isInitialized = _cameraController?.value.isInitialized ?? false;

    ref.listen(checkOutProvider, (prev, next) {
      next.when(
        idle: () => null,
        loading: () {
          _cameraController?.pausePreview();
        },
        success: (_) {
          _cameraController?.resumePreview();

          AppDialog.showSuccess(
            context: context,
            title: 'Berhasil',
            message: 'Checkout berhasil, silahkan cek kembali di halaman daftar laporan',
            buttonText: 'Lihat Laporan',
            barrierDismissible: false,
            onButtonPressed: () {
              ref.read(reportPagingProvider).refresh();
              ref.read(countReportsProvider.notifier).fetchCount();

              context.goNamed('history_report');
            },
          );
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
            onConfirm: () => context.goNamed('history_report'),
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
              Text('Konfirmasi Keluar',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 18,
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Silakan melakukan foto selfie untuk konfirmasi keluar',
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
              if (isLoading) return;

            AppDialog.showConfirm(
              context: context,
              title: 'Konfirmasi',
              message: 'Apakah Anda yakin ingin keluar dari halaman ini?',
              onConfirm: () => context.goNamed('history_report'),
            );
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: Container(
              color: colorScheme.surface,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: AppAlertCard(
                title: 'Cabang',
                message: widget.branchName ?? '',
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
                child: _buildButton(),
              ),
            ],

            // Loading overlay
            if (isLoading) ...[
              AppLoading(message: 'Memproses kunjungan...'),
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

  Widget _buildSelfieSection() {
    final isCameraReady = ref.watch(cameraProvider.select((s) => s.isInitializing));
    final isInitialized = _cameraController?.value.isInitialized ?? false;

    if (isCameraReady) {
      return AppLoading(message: 'Mempersiapkan kamera...');
    }

    if (!isInitialized) return const SizedBox.shrink();

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

  Widget _buildButton() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isLoading = ref.watch(checkOutProvider.select((s) => s.isLoading));
    
    return _selfieImage == null ? GestureDetector(
      onTap: isLoading ? null : () async => await _onCapture(),
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
