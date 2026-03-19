import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/app/constants/app_routes.dart';
import 'package:patroli/app/router/route_args/visit_route_args.dart';
import 'package:patroli/core/enums/alert_type.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/app/camera/camera_provider.dart';
import 'package:patroli/core/services/camera_service.dart';
import 'package:patroli/core/services/permission_service.dart';
import 'package:patroli/core/ui/buttons/app_icon_button.dart';
import 'package:patroli/core/ui/cards/app_card_alert.dart';
import 'package:patroli/core/ui/dialogs/app_dialog.dart';
import 'package:patroli/core/ui/widgets/app_loading.dart';
import 'package:patroli/features/check_in/presentation/providers/check_in_flow_provider.dart';
import 'package:patroli/features/reports/application/coordinators/reports_refresh_coordinator_provider.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:patroli/l10n/l10n.dart';
import 'package:patroli/core/utils/screen_util.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  final ScanQrEntity? scanQrData;

  const CheckInScreen({super.key, this.scanQrData});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  CameraController? _cameraController;
  bool _isCameraPermissionDenied = false;

  final double _mirror = 1.0;

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 300));
      await _initCamera();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed &&
        _isCameraPermissionDenied &&
        mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _initCamera();
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
      final hasPermission =
          await PermissionService.checkAndRequestCameraPermission(
            context: context,
          );

      if (!hasPermission) {
        notifier.setInitializing(false);
        if (mounted) {
          setState(() => _isCameraPermissionDenied = true);
        }
        return;
      }

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

      setState(() {
        _cameraController = controller;
        _isCameraPermissionDenied = false;
      });

      ref.read(cameraProvider.notifier).setInitializing(false);
    } catch (e) {
      ref.read(cameraProvider.notifier).setInitializing(false);

      if (!mounted) return;
      AppDialog.showError(
        context: context,
        title: context.tr('failed'),
        message: e.toString(),
        buttonText: context.tr('try_again'),
        onButtonPressed: () async => await _initCamera(),
      );
    }
  }

  Future<void> _onCapture() async {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _cameraController!.value.isTakingPicture) {
      return;
    }

    await _animationController.forward();
    await _animationController.reverse();

    final image = await _cameraController!.takePicture();
    await ref.read(checkInFlowProvider.notifier).captureSelfie(image);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final flowState = ref.watch(checkInFlowProvider);

    ref.listen(checkInFlowProvider.select((s) => s.uploadState), (prev, next) {
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
            title: context.tr('failed'),
            message: msg,
          );
        },
      );
    });

    ref.listen(checkInFlowProvider.select((s) => s.submissionState), (
      prev,
      next,
    ) {
      next.when(
        idle: () => null,
        loading: () => null,
        success: (value) {
          if (!mounted) return;
          AppDialog.showSuccess(
            context: context,
            title: context.tr('success'),
            message: context.tr('check_in_success_message'),
            buttonText: context.tr('continue'),
            barrierDismissible: false,
            onButtonPressed: () async {
              await ref
                  .read(reportsRefreshCoordinatorProvider)
                  .refreshReportsAndDashboard();
              if (!context.mounted) return;
              context.pushReplacement(
                AppRoutes.visit,
                extra: VisitRouteArgs(
                  scanQr: widget.scanQrData,
                  checkIn: value,
                ),
              );
            },
          );
        },
        error: (msg) {
          _cameraController?.resumePreview();

          if (!mounted) return;
          AppDialog.showError(
            context: context,
            title: context.tr('failed'),
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
          if (flowState.isBusy) return;

          AppDialog.showConfirm(
            context: context,
            title: context.tr('confirmation'),
            message: context.tr('leave_page_confirmation'),
            onConfirm: () => context.go(AppRoutes.home),
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
              Text(
                context.tr('check_in_confirmation_title'),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: ScreenUtil.sp(18),
                  color: color.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                context.tr('check_in_confirmation_subtitle'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: ScreenUtil.sp(12),
                  color: color.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () {
              // Prevent back if loading
              if (flowState.isBusy) return;

              AppDialog.showConfirm(
                context: context,
                title: context.tr('confirmation'),
                message: context.tr('leave_page_confirmation'),
                onConfirm: () => context.go(AppRoutes.home),
              );
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(ScreenUtil.sh(90)),
            child: Container(
              color: color.surface,
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil.sw(16),
                vertical: ScreenUtil.sh(10),
              ),
              child: AppAlertCard(
                title: context.tr('branch'),
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
              bottom: isInitialized ? ScreenUtil.sh(280) : 0,
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
            if (flowState.isBusy) ...[
              AppLoading(
                message: flowState.isUploading
                    ? context.tr('processing_selfie')
                    : context.tr('processing_visit'),
              ),
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
          padding: ScreenUtil.paddingFromDesign(all: 16),
          decoration: BoxDecoration(
            color: color.surface,
            borderRadius: BorderRadius.circular(ScreenUtil.radius(25)),
            border: Border.all(color: color.outline.withValues(alpha: 0.2)),
          ),
          child: Icon(
            Iconsax.shop,
            size: ScreenUtil.icon(48),
            color: color.primary,
          ),
        ),
        SizedBox(height: ScreenUtil.sh(16)),
        Text(
          context.tr('branch_data_not_found'),
          style: theme.textTheme.titleMedium?.copyWith(
            color: color.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: ScreenUtil.sh(16)),
        AppIconButton(
          onPressed: () => context.go(AppRoutes.home),
          label: context.tr('back_to_home'),
          icon: Icon(Iconsax.home),
          type: IconButtonType.primary,
        ),
      ],
    );
  }

  Widget _buildSelfieSection() {
    final isCameraReady = ref.watch(
      cameraProvider.select((s) => s.isInitializing),
    );
    final flowState = ref.watch(checkInFlowProvider);
    final isInitialized = _cameraController?.value.isInitialized ?? false;

    if (isCameraReady) {
      return AppLoading(message: context.tr('camera_preparing'));
    }

    if (_isCameraPermissionDenied) {
      return _buildPermissionDeniedWidget();
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

              if (flowState.selfieImage != null) ...[
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateY(_mirror == 1.0 ? math.pi : 0),
                  child: Image.file(
                    File(flowState.selfieImage!.path),
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

  Widget _buildPermissionDeniedWidget() {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Iconsax.camera_slash,
            size: ScreenUtil.icon(50),
            color: color.onSurface,
          ),
          SizedBox(height: ScreenUtil.sh(10)),
          Text(
            context.tr('camera_permission_not_granted'),
            style: theme.textTheme.titleMedium?.copyWith(
              color: color.onSurface,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ScreenUtil.sh(10)),
          AppIconButton(
            height: ScreenUtil.sh(40),
            label: context.tr('allow'),
            icon: const Icon(Icons.settings),
            onPressed: () async => PermissionService.openSettings(),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonBottom(ScanQrEntity scanQrData) {
    final color = Theme.of(context).colorScheme;

    final flowState = ref.watch(checkInFlowProvider);
    final primaryLabel = flowState.isUploadFailed
        ? context.tr('try_again')
        : context.tr('continue_action');

    return !flowState.hasSelfie
        ? GestureDetector(
            onTap: flowState.isBusy ? null : () async => await _onCapture(),
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                );
              },
              child: Container(
                width: ScreenUtil.sw(80),
                height: ScreenUtil.sw(80),
                margin: ScreenUtil.paddingFromDesign(all: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: ScreenUtil.sw(4),
                    color: color.onSurface,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: ScreenUtil.sw(60),
                    height: ScreenUtil.sw(60),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.sh(30),
              horizontal: ScreenUtil.sw(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AppIconButton(
                    onPressed: () =>
                        ref.read(checkInFlowProvider.notifier).retake(),
                    label: context.tr('retake_photo'),
                    type: IconButtonType.outlined,
                    icon: const Icon(Iconsax.camera5),
                  ),
                ),
                SizedBox(width: ScreenUtil.sw(16)),
                Expanded(
                  child: AppIconButton(
                    onPressed: flowState.isUploadFailed
                        ? () async => ref
                              .read(checkInFlowProvider.notifier)
                              .retryUpload()
                        : !flowState.isReadyToSubmit
                        ? null
                        : () => ref
                              .read(checkInFlowProvider.notifier)
                              .submit(branchId: scanQrData.id ?? 0),
                    label: primaryLabel,
                    icon: flowState.isUploadFailed
                        ? const Icon(Iconsax.refresh)
                        : const Icon(Iconsax.next),
                    type: IconButtonType.primary,
                  ),
                ),
              ],
            ),
          );
  }
}
