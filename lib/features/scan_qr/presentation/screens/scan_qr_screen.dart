import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patroli/app/constants/app_routes.dart';
import 'package:patroli/core/enums/alert_type.dart';
import 'package:patroli/core/ui/bottom_sheets/app_bottom_sheet.dart';
import 'package:patroli/core/ui/buttons/app_icon_button.dart';
import 'package:patroli/core/ui/cards/app_card_alert.dart';
import 'package:patroli/core/ui/dialogs/app_dialog.dart';
import 'package:patroli/core/ui/inputs/app_text_field.dart';
import 'package:patroli/core/ui/widgets/app_loading.dart';
import 'package:patroli/core/utils/screen_util.dart';
import 'package:patroli/features/scan_qr/presentation/providers/scan_qr_flow_provider.dart';
import 'package:patroli/l10n/l10n.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  const ScanQrScreen({super.key});

  @override
  ConsumerState<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen>
    with WidgetsBindingObserver {
  late MobileScannerController _controller;
  final TextEditingController _branchCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = _buildController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkCameraPermission();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _branchCodeController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _checkCameraPermission();
      });
    }
  }

  MobileScannerController _buildController() {
    return MobileScannerController(
      autoStart: false,
      formats: [BarcodeFormat.qrCode],
    );
  }

  Future<void> _checkCameraPermission() async {
    final hasPermission = await ref
        .read(scanQrFlowProvider.notifier)
        .checkCameraPermission();

    if (hasPermission) {
      await _controller.start();
    }
  }

  Future<void> _rebuildScanner() async {
    final oldController = _controller;
    final newController = _buildController();

    setState(() {
      _controller = newController;
    });

    await oldController.dispose();
    ref.read(scanQrFlowProvider.notifier).resetScanState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkCameraPermission();
    });
  }

  Future<void> _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null || !mounted) return;

    final l10n = AppLocalizations.of(context);
    final result = await _controller.analyzeImage(image.path);

    if (result != null && result.barcodes.isNotEmpty) {
      final barcode = result.barcodes.first;
      final qrCode = barcode.rawValue ?? barcode.displayValue ?? '';
      await _handleScannedCode(qrCode);
      return;
    }

    ref
        .read(scanQrFlowProvider.notifier)
        .setGalleryNotFoundError(l10n.translate('qr_not_found_in_image'));
  }

  Future<void> _handleScannedCode(String qrCode) async {
    await ref.read(scanQrFlowProvider.notifier).handleScannedCode(qrCode);
  }

  Future<void> _showBranchCodeModal() async {
    final isLoading = ref.watch(scanQrFlowProvider.select((s) => s.isLoading));

    await AppBottomSheet.showWithKeyboard(
      context: context,
      builder: (context) => _buildBranchCodeModal(isLoading: isLoading),
    );
  }

  @override
  Widget build(BuildContext context) {
    final flowState = ref.watch(scanQrFlowProvider);

    ref.listen(scanQrFlowProvider, (prev, next) {
      final previousData = prev?.scannedEntity;
      final nextData = next.scannedEntity;

      if (nextData != null && nextData != previousData) {
        _controller.pause();
        context.pushReplacement(AppRoutes.checkIn, extra: nextData);
        return;
      }

      final previousError = prev?.errorMessage;
      final nextError = next.errorMessage;

      if (nextError != null && nextError != previousError) {
        _controller.pause();

        if (!mounted) return;

        AppDialog.showError(
          context: context,
          title: context.tr('failed'),
          message: nextError,
          buttonText: context.tr('ok'),
          onButtonPressed: () async => _rebuildScanner(),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          if (flowState.isCameraPermissionGranted != true)
            Positioned(child: Center(child: _buildPermissionDeniedWidget()))
          else ...[
            Positioned.fill(child: _buildScanner()),
            if (flowState.isLoading)
              AppLoading(message: context.tr('processing_qr')),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [_buildPoweredBy(), _buildBottomMenu()],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPermissionDeniedWidget() {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Iconsax.camera_slash,
          size: ScreenUtil.icon(50),
          color: color.onSurface,
        ),
        SizedBox(height: ScreenUtil.sh(10)),
        Text(
          context.tr('camera_permission_not_granted'),
          style: TextStyle(
            fontSize: ScreenUtil.sp(16),
            fontWeight: FontWeight.w500,
            color: color.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: ScreenUtil.sh(10)),
        AppIconButton(
          height: ScreenUtil.sh(40),
          label: context.tr('allow'),
          icon: const Icon(Icons.settings),
          onPressed: () async => openAppSettings(),
        ),
      ],
    );
  }

  Widget _buildScanner() {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final flowState = ref.watch(scanQrFlowProvider);

    return AiBarcodeScanner(
      key: ValueKey(_controller),
      controller: _controller,
      galleryButtonType: GalleryButtonType.none,
      appBarBuilder: (context, controller) {
        return _buildAppBar(flowState.isTorchOn);
      },
      onDetect: (value) {
        if (flowState.isLoading || flowState.isProcessing) return;

        if (value.barcodes.isNotEmpty) {
          final barcode = value.barcodes.first;
          final qrCode = barcode.rawValue ?? barcode.displayValue ?? '';
          _handleScannedCode(qrCode);
        }
      },
      validator: (value) => value.barcodes.isNotEmpty,
      onDispose: () {
        debugPrint('Scanner disposed');
      },
      onDetectError: (Object error, StackTrace stackTrace) {
        debugPrint('Scanner error: $error');
      },
      overlayConfig: ScannerOverlayConfig(
        curve: Curves.easeInOut,
        borderColor: Colors.transparent,
        animationColor: color.primary,
        scannerBorder: ScannerBorder.none,
        scannerAnimation: flowState.isError
            ? ScannerAnimation.none
            : ScannerAnimation.fullWidth,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isTorchOn) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: CircleAvatar(
              radius: ScreenUtil.radius(20),
              backgroundColor: Colors.grey.shade800,
              child: Icon(Iconsax.arrow_left, color: Colors.grey.shade400),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    await ref
                        .read(scanQrFlowProvider.notifier)
                        .toggleTorch(_controller);
                  },
                  child: CircleAvatar(
                    radius: ScreenUtil.radius(20),
                    backgroundColor: Colors.grey.shade800,
                    child: Icon(
                      isTorchOn ? Iconsax.flash_slash : Iconsax.flash_1,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoweredBy() {
    return Container(
      padding: EdgeInsets.only(bottom: ScreenUtil.sh(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Powered by',
            style: TextStyle(
              fontSize: ScreenUtil.sp(12),
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: ScreenUtil.sw(8)),
          Image.asset(
            'assets/images/logos/pgi-horizontal-white.webp',
            height: ScreenUtil.sh(25),
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomMenu() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLoading = ref.watch(scanQrFlowProvider.select((s) => s.isLoading));

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil.sw(16),
        vertical: ScreenUtil.sh(16),
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ScreenUtil.radius(25)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppAlertCard(
            title: context.tr('scan_qr_help_title'),
            message: context.tr('scan_qr_help_message'),
            type: AlertType.custom,
            customIcon: CupertinoIcons.question_circle,
          ),
          SizedBox(height: ScreenUtil.sh(12)),
          Row(
            children: [
              Expanded(
                child: AppIconButton(
                  fontSize: 13,
                  onPressed: isLoading ? null : _pickImageFromGallery,
                  icon: const Icon(Iconsax.gallery_add5),
                  label: context.tr('upload_from_gallery'),
                  type: IconButtonType.outlined,
                ),
              ),
              SizedBox(width: ScreenUtil.sw(10)),
              Expanded(
                child: AppIconButton(
                  fontSize: 13,
                  onPressed: isLoading ? null : _showBranchCodeModal,
                  icon: const Icon(Iconsax.keyboard5),
                  label: context.tr('enter_branch_code'),
                  type: IconButtonType.outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBranchCodeModal({required bool isLoading}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBottomSheet.buildHeader(
          context: context,
          title: context.tr('enter_branch_code'),
        ),
        SizedBox(height: ScreenUtil.sh(10)),
        AppTextField(
          cursor: true,
          label: context.tr('branch_code'),
          hint: context.tr('branch_code_hint'),
          controller: _branchCodeController,
          keyboardType: TextInputType.text,
          prefixIcon: const Icon(Iconsax.code),
          textCapitalization: TextCapitalization.characters,
        ),
        SizedBox(height: ScreenUtil.sh(16)),
        AppIconButton(
          label: context.tr('continue'),
          icon: const Icon(Iconsax.next),
          minimumSize: Size(double.infinity, ScreenUtil.sh(45)),
          onPressed: isLoading
              ? null
              : () async {
                  final branchCode = _branchCodeController.text.trim();
                  if (branchCode.isEmpty || !mounted) return;

                  context.pop();
                  await _handleScannedCode(branchCode);
                },
        ),
      ],
    );
  }
}
