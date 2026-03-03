import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/features/scan_qr/presentation/controllers/scan_qr_controller.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_state_provider.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  const ScanQrScreen({super.key});

  @override
  ConsumerState<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeIn),
    );
    _fadeAnimationController.forward();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              _buildHeader(colorScheme, textTheme),
              Expanded(
                child: _buildScannerArea(colorScheme, textTheme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.qr_code_scanner_rounded,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scan QR Code',
                  style: textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Arahkan kamera ke QR Code',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerArea(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildScannerPlaceholder(colorScheme, textTheme),
          const SizedBox(height: 32),
          _buildInstructions(colorScheme, textTheme),
          const Spacer(),
          _buildScanButton(colorScheme, textTheme),
        ],
      ),
    );
  }

  Widget _buildScannerPlaceholder(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Consumer(
      builder: (context, ref) {
        final scanState = ref.watch(scanQrStateProvider);

        return Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: scanState.isScanning
                      ? colorScheme.surfaceVariant
                      : colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: scanState.isScanning
                        ? colorScheme.surfaceVariant
                        : colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.qr_code_2_rounded,
                    size: 64,
                    color: scanState.isScanning
                        ? colorScheme.primary
                        : colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                scanState.isScanning ? 'Sedang memindai...' : 'Siap memindai',
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              if (scanState.isLoading)
                SizedBox(
                  width: 40,
                  height: 4,
                  child: LinearProgressIndicator(
                    backgroundColor: colorScheme.surface,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      scanState.isLoading ? Colors.grey : colorScheme.primary,
                    ),
                  ),
                ),
            ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInstructions(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInstructionItem(
            icon: Icons.center_focus_strong,
            title: 'Pastikan QR Code jelas',
            description: 'Hindari glare atau blur',
          ),
          const SizedBox(height: 12),
          _buildInstructionItem(
            icon: Icons.light_mode,
            title: 'Pencahayaan yang cukup',
            description: 'Pastikan area terang benderang',
          ),
          const SizedBox(height: 12),
          _buildInstructionItem(
            icon: Icons.visibility,
            title: 'Jarak yang tepat',
            description: '8-15 cm dari kamera',
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: const Color(0xFF757575),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScanButton(
    ColorScheme colorScheme,
    TextTheme textTheme,
    WidgetRef ref,
  ) {
    return Consumer(
      builder: (context, ref) {
        final scanState = ref.watch(scanQrStateProvider);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ElevatedButton(
            onPressed: scanState.isLoading
                ? null
                : () => _handleScan(ref),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              backgroundColor:
                  scanState.isLoading
                      ? colorScheme.surfaceContainerHighest
                      : colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: scanState.isLoading ? 0 : 8,
              shadowColor: colorScheme.primary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  scanState.isScanning ? 'Memindai...' : 'Mulai Scan',
                  style: textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleScan(WidgetRef ref) async {
    final controller = ref.read(scanQrControllerProvider.notifier);
    final stateNotifier = ref.read(scanQrStateProvider.notifier);

    stateNotifier.startScanning();

    try {
      await Future.delayed(const Duration(seconds: 2));

      await controller.scanQr(qrcode: 'SAMPLE_QR_CODE');

      if (mounted) {
        AppDialog.showSuccess(
          context: context,
          title: 'Scan Berhasil!',
          message: 'QR Code berhasil dipindai: SAMPLE_QR_CODE',
          buttonText: 'OK',
        );
      }
    } catch (e) {
      if (mounted) {
        AppDialog.showError(
          context: context,
          title: 'Scan Gagal',
          message: 'Gagal memindai QR Code: ${e.toString()}',
          buttonText: 'Coba Lagi',
        );
      }
    }
  }
}
