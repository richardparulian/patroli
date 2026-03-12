import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/extensions/helper_state_extension.dart';
import 'package:pos/core/ui/buttons/app_icon_button.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/core/ui/inputs/app_checkbox_group.dart';
import 'package:pos/core/ui/inputs/app_radio_group.dart';
import 'package:pos/core/ui/inputs/app_text_field.dart';
import 'package:pos/core/ui/widgets/app_loading.dart';
import 'package:pos/core/utils/screen_util.dart';
import 'package:pos/features/check_in/domain/entities/argument_entity.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/check_out/presentation/providers/check_out_provider.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/visits/data/dtos/request/visit_request.dart';
import 'package:pos/features/visits/presentation/providers/visit_attention_provider.dart';
import 'package:pos/features/visits/presentation/providers/visit_create_provider.dart';
import 'package:pos/features/visits/presentation/providers/visit_form_provider.dart';

class VisitScreen extends ConsumerStatefulWidget {
  const VisitScreen({super.key});

  @override
  ConsumerState<VisitScreen> createState() => _VisitScreenState();
}

class _VisitScreenState extends ConsumerState<VisitScreen> {
  late TextEditingController noteController;
  late FocusNode noteFocusNode;

  @override
  void initState() {
    super.initState();

    noteController = TextEditingController();
    noteFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args = GoRouterState.of(context).extra as CheckInRouteArgs?;

      final scanQrData = args?.scanQr;

      await ref.read(visitAttentionProvider.notifier).runVisitAttention(scanQrData?.qrcode ?? '');
    });
  }

  @override
  void dispose() {
    noteController.dispose();
    noteFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final args = GoRouterState.of(context).extra as CheckInRouteArgs?;

    final scanQrData = args?.scanQr;

    final isLoadingCheckOut = ref.watch(checkOutProvider.select((s) => s.isLoading));
    final isLoadingVisitAttention = ref.watch(visitAttentionProvider.select((s) => s.isLoading));

    ref.listen(visitCreateProvider, (previous, next) {
       next.when(
        idle: () => null,
        loading: () => null,
        success: (value) {
          if (!mounted) return;
          AppDialog.showSuccess(
            context: context,
            title: 'Berhasil',
            message: 'Laporan berhasil dikirim, silahkan lanjut ke proses berikutnya',
            buttonText: 'Lanjut',
            barrierDismissible: false,
            onButtonPressed: () {
              context.push(AppConstants.checkOutRoute, extra: {
                'reportId': value.id ?? 0,
                'branchId': scanQrData?.id ?? 0,
                'branchName': scanQrData?.name ?? '-',
              });

              ref.read(visitFormProvider.notifier).reset();
            },
          );
        },
        error: (msg) => null,
      );
    });

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // Prevent back if loading
          if (isLoadingVisitAttention || isLoadingCheckOut) return;

          AppDialog.showConfirm(
            context: context,
            title: 'Konfirmasi',
            message: 'Apakah Anda yakin ingin keluar dari halaman ini?',
            onConfirm: () {
              ref.read(visitFormProvider.notifier).reset();
              context.goNamed('history_report');
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: color.surface,
          surfaceTintColor: color.surface,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Buat Laporan',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 18,
                  color: color.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Silakan isi form dibawah ini untuk membuat laporan',
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
              if (isLoadingVisitAttention || isLoadingCheckOut) return;

              AppDialog.showConfirm(
                context: context,
                title: 'Konfirmasi',
                message: 'Apakah Anda yakin ingin keluar dari halaman ini?',
                onConfirm: () {
                  ref.read(visitFormProvider.notifier).reset();
                  context.goNamed('history_report');
                },
              );
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16, 
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: color.surface,
                border: Border(
                  bottom: BorderSide(
                    color: color.outline.withValues(alpha: 0.2),
                  ),
                )
              ),
              child: _buildInfoCard(
                icon: Icons.store,
                title: 'Cabang',
                colors: color.primary,
                value: scanQrData?.name ?? '---',
              ),
            ),
          ),
        ),
        body: _buildFormSection(isLoadingCheckOut: isLoadingCheckOut),
      ),
    );
  }

  Widget _buildFormSection({required bool isLoadingCheckOut}) {
    final args = GoRouterState.of(context).extra as CheckInRouteArgs?;

    final checkInData = args?.checkIn;

    final form = ref.watch(visitFormProvider);
    final notifier = ref.watch(visitFormProvider.notifier);

    final isLoadingVisitCreate = ref.watch(visitCreateProvider.select((s) => s.isLoading));

    return ref.watch(visitAttentionProvider).when(
      idle: () => AppLoading(message: 'Menunggu data...'),
      loading: () => AppLoading(message: 'Memproses pengambilan data...'),
      success: (visitData) => SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            if (visitData.visitAttention?.requireAttentions == 1) ...[
              const SizedBox(height: 10),
              _buildInfoCard(
                icon: Iconsax.danger,
                title: 'Perhatian!',
                colors: Colors.orange,
                value: visitData.visitAttention?.notes ?? '--',
              ),
            ],
            const SizedBox(height: 10),
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
              errorText: form.errors['bannerStatus'],
              options: const ['Bagus', 'Rusak'],
              onChanged: notifier.setBannerUtama,
            ),
            const SizedBox(height: 10),
            AppRadioGroup<String>(
              title: 'Rolling Door',
              icon: Icons.door_front_door,
              value: form.rollingDoor,
              errorText: form.errors['rollingDoorStatus'],
              options: const ['Tertutup Rapat', 'Terbuka/Renggang'],
              onChanged: notifier.setRollingDoor,
            ),
            const SizedBox(height: 10),
            AppCheckboxGroup(
              errorText: form.errors['rollingDoorChecklist'],
              options: const [
                'Saya sudah menyinari rolling door menggunakan senter',
                'Saya sudah melakukan tahap gedor rolling door',
              ],
              values: form.rollingDoorChecklist,
              onChanged: notifier.setRollingDoorChecklist,
            ),
            const SizedBox(height: 10),
            AppRadioGroup<String>(
              title: 'Kondisi Cabang (Kanan)',
              icon: Iconsax.sidebar_right,
              value: form.conditionRight,
              notes: visitData.visitAttention?.conditionRightNotes?.trim() ?? '',
              errorText: form.errors['conditionRight'],
              options: const ['Aman', 'Taruna'],
              onChanged: notifier.setConditionRight,
            ),
            const SizedBox(height: 10),
            AppRadioGroup<String>(
              title: 'Kondisi Cabang (Kiri)',
              icon: Iconsax.sidebar_left,
              value: form.conditionLeft,
              notes: visitData.visitAttention?.conditionLeftNotes?.trim() ?? '',
              errorText: form.errors['conditionLeft'],
              options: const ['Aman', 'Taruna'],
              onChanged: notifier.setConditionLeft,
            ),
            const SizedBox(height: 10),
            AppRadioGroup<String>(
              title: 'Kondisi Cabang (Belakang)',
              icon: Iconsax.undo,
              value: form.conditionBack,
              notes: visitData.visitAttention?.conditionBackNotes?.trim() ?? '',
              errorText: form.errors['conditionBack'],
              options: const ['Aman', 'Taruna'],
              onChanged: notifier.setConditionBack,
            ),
            const SizedBox(height: 10),
            AppRadioGroup<String>(
              title: 'Kondisi Cabang (Sekitar)',
              icon: Iconsax.story,
              value: form.conditionAround,
              notes: visitData.visitAttention?.conditionAroundNotes?.trim() ?? '',
              errorText: form.errors['conditionAround'],
              options: const ['Ruko Kosong', 'Sepi', 'Ramai'],
              onChanged: notifier.setconditionAround,
            ),
            const SizedBox(height: 15),
            AppTextField(
              radius: 16,
              cursor: true,
              isDense: false,
              label: 'Catatan (Opsional)',
              hint: 'Masukkan catatan',
              focusNode: noteFocusNode,
              controller: noteController,
              isMultiline: true,
            ),
            const SizedBox(height: 20),
            AppIconButton(
              label: 'Kirim',
              icon: isLoadingVisitCreate ? SizedBox(
                height: ScreenUtil.sw(14),
                width: ScreenUtil.sw(14),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  strokeCap: StrokeCap.round,
                  color: Colors.white,
                ),
              ) : Icon(Iconsax.send_1),
              type: IconButtonType.primary,
              minimumSize: const Size(double.infinity, 45),
              onPressed: isLoadingVisitCreate ? null : () async {
                noteFocusNode.unfocus();

                final isValid = notifier.validate();

                if (!isValid) return;

                AppDialog.showConfirm(
                  context: context,
                  title: 'Konfirmasi',
                  message: 'Apakah Anda yakin ingin mengirim laporan ini?',
                  onConfirm: () async {
                    await ref.read(visitCreateProvider.notifier).runVisitCreate(
                      request: VisitRequest(
                        lightsStatus: form.lampuBanner ?? '',
                        bannerStatus: form.bannerUtama ?? '',
                        rollingDoorStatus: form.rollingDoor ?? '',
                        conditionRight: form.conditionRight ?? '',
                        conditionLeft: form.conditionLeft ?? '',
                        conditionBack: form.conditionBack ?? '',
                        conditionAround: form.conditionAround ?? '', 
                        notes: noteController.text.trim(),
                      ),
                      reportId: checkInData.id,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      error: (msg) => Center(child: Text('Error: $msg')),
    );
  }

  Widget _buildInfoCard({required IconData icon, required Color colors, required String title, required String? value}) {
    final theme = Theme.of(context);
    
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colors.withValues(alpha: .2),
        ),
      ),
      color: colors.withValues(alpha: .1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: colors),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(value ?? '---',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
