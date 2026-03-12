import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/core/ui/inputs/app_checkbox_group.dart';
import 'package:pos/core/ui/inputs/app_radio_group.dart';
import 'package:pos/core/ui/inputs/app_text_field.dart';
import 'package:pos/core/ui/widgets/app_loading.dart';
import 'package:pos/core/utils/screen_util.dart';
import 'package:pos/features/check_out/presentation/providers/check_out_notifier_provider.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/visits/presentation/providers/visit_form_provider.dart';
import 'package:pos/features/visits/presentation/widgets/form_section.dart';

class VisitScreen extends ConsumerStatefulWidget {
  const VisitScreen({super.key});

  @override
  ConsumerState<VisitScreen> createState() => _VisitScreenState();
}

class _VisitScreenState extends ConsumerState<VisitScreen> with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  
  
  @override
  void initState() {
    super.initState();

    
  }

  @override
  void dispose() {
    

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final form = ref.watch(visitFormProvider);
    final notifier = ref.read(visitFormProvider.notifier);

    final branchData = GoRouterState.of(context).extra as ReportsEntity?;
    final isLoading = ref.watch(checkOutProvider.select((s) => s.isLoading));

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
            onConfirm: () => context.pop,
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
              Text('Buat Laporan',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 18,
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Silakan isi form dibawah ini untuk membuat laporan',
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
                onConfirm: () => context.pop,
              );
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight + MediaQuery.of(context).padding.bottom),
            child: Container(
              color: colorScheme.surface,
              child: _buildInfoCard(
                icon: Icons.store,
                title: 'Cabang',
                value: branchData.branch?.name ?? '-',
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            // Positioned.fill(
            //   bottom: isInitialized ? 140 * 2 : 0,
            //   child: _buildSelfieSection(branchData),
            // ),

            // if (isInitialized) ...[
            //   Positioned(
            //     bottom: 0,
            //     left: 0,
            //     right: 0,
            //     child: _buildButton(branchData),
            //   ),
            // ],

            // Loading overlay
            if (isLoading) ...[
              AppLoading(message: 'Memproses pembuatan laporan...'),
            ],

            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppRadioGroup<String>(
                    title: 'Lampu Banner',
                    icon: Iconsax.lamp_charge,
                    value: form.lampuBanner,
                    errorText: form.errors['lightsStatus'],
                    options: const ['Menyala', 'Mati'],
                    onChanged: notifier.setLampuBanner,
                  ),
                  const SizedBox(height: 10),
                  AppRadioGroup<String>(
                    title: 'Banner Utama',
                    icon: Iconsax.image,
                    value: form.bannerUtama,
                    options: const ['Bagus', 'Rusak'],
                    onChanged: notifier.setBannerUtama,
                  ),
                  const SizedBox(height: 10),
                  AppRadioGroup<String>(
                    title: 'Rolling Door',
                    icon: Icons.door_front_door,
                    value: form.rollingDoor,
                    options: const ['Tertutup Rapat', 'Terbuka/Renggang'],
                    onChanged: notifier.setRollingDoor,
                  ),
                  const SizedBox(height: 10),
                  AppCheckboxGroup(
                    options: const [
                      'Saya sudah menyinari rolling door menggunakan senter',
                      'Saya sudah melakukan tahap gedor rolling door',
                    ],
                    values: form.rollingDoorChecklist,
                    onChanged: notifier.setRollingDoorChecklist,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildErrorWidget(IconData iconMessage, String message, String buttonText, IconData iconButton, VoidCallback onButtonPressed) {
  //   final theme = Theme.of(context);
  //   final colorScheme = theme.colorScheme;
    
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.all(16),
  //         decoration: BoxDecoration(
  //           color: colorScheme.surface,
  //           borderRadius: BorderRadius.circular(25),
  //           border: Border.all(
  //             color: colorScheme.outline.withValues(alpha: 0.2),
  //           ),
  //         ),
  //         child: Icon(iconMessage, size: 48, color: colorScheme.primary),
  //       ),
  //       const SizedBox(height: 16),
  //       Text(message,
  //         style: theme.textTheme.titleMedium?.copyWith(
  //           color: colorScheme.onSurface,
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //       AppIconButton(
  //         onPressed: onButtonPressed,
  //         label: buttonText,
  //         icon: Icon(iconButton),
  //         type: IconButtonType.primary,
  //       )
  //     ],
  //   );
  // }

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

  // Widget _buildSelfieSection(ReportsEntity branchData) {
  //   final isCameraReady = ref.watch(cameraProvider.select((s) => s.isInitializing));
  //   final isInitialized = _cameraController?.value.isInitialized ?? false;

  //   if (isCameraReady) {
  //     return AppLoading(message: 'Mempersiapkan kamera...');
  //   }

  //   if (!isInitialized) return const SizedBox.shrink();

  //   final previewSize = _cameraController?.value.previewSize;

  //   if (previewSize == null) {
  //     return const SizedBox.shrink();
  //   }

  //   return SizedBox.expand(
  //     child: FittedBox(
  //       fit: BoxFit.cover,
  //       child: SizedBox(
  //         width: _cameraController?.value.previewSize!.height ?? 0,
  //         height: _cameraController?.value.previewSize!.width ?? 0,
  //         child: Stack(
  //         fit: StackFit.expand,
  //           children: [
  //             CameraPreview(_cameraController!),

  //             if (_selfieImage != null) ...[
  //               Transform(
  //                 alignment: Alignment.center,
  //                 transform: Matrix4.identity()..rotateY(_mirror == 1.0 ? math.pi : 0),
  //                 child: Image.file(
  //                   File(_selfieImage!.path),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ],
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildButton(ReportsEntity branchData) {
  //   final theme = Theme.of(context);
  //   final colorScheme = theme.colorScheme;

  //   final isLoading = ref.watch(checkOutProvider.select((s) => s.isLoading));
    
  //   return _selfieImage == null ? GestureDetector(
  //     onTap: isLoading ? null : () async => await _onCapture(),
  //     child: AnimatedBuilder(
  //       animation: _scaleAnimation, 
  //       builder: (context, child) {
  //         return Transform.scale(
  //           scale: _scaleAnimation.value,
  //           child: child,
  //         );
  //       },
  //       child: Container(
  //         width: 80,
  //         height: 80,
  //         margin: const EdgeInsets.all(16),
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           border: Border.all(
  //             width: 4,
  //             color: colorScheme.onSurface,
  //           ),
  //         ),
  //         child: Center(
  //           child: Container(
  //             width: 60,
  //             height: 60,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               color: colorScheme.onSurface,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   ) : Padding(
  //     padding: const EdgeInsets.symmetric(
  //       vertical: 30,
  //       horizontal: 16,
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Expanded(
  //           child: AppIconButton(
  //             onPressed: () => setState(() => _selfieImage = null),
  //             label: 'Foto Ulang',
  //             type: IconButtonType.outlined,
  //             icon: const Icon(Iconsax.camera5),
  //           ),
  //         ),
  //         const SizedBox(width: 16),
  //         Expanded(
  //           child: AppIconButton(
  //             onPressed: () => setState(() => _selfieImage = null),
  //             label: 'Lanjutkan',
  //             icon: const Icon(Iconsax.next),
  //             type: IconButtonType.primary,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
