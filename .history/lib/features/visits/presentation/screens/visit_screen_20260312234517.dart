import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/entities/check_out_entity.dart';
import 'package:pos/core/enums/alert_type.dart';
import 'package:pos/core/extensions/helper_state_extension.dart';
import 'package:pos/core/ui/buttons/app_icon_button.dart';
import 'package:pos/core/ui/cards/app_card_alert.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/core/ui/inputs/app_checkbox_group.dart';
import 'package:pos/core/ui/inputs/app_radio_group.dart';
import 'package:pos/core/ui/inputs/app_text_field.dart';
import 'package:pos/core/ui/widgets/app_loading.dart';
import 'package:pos/core/utils/screen_util.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/check_out/presentation/providers/check_out_provider.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/visits/data/dtos/request/visit_request.dart';
import 'package:pos/features/visits/presentation/providers/visit_attention_provider.dart';
import 'package:pos/features/visits/presentation/providers/visit_create_provider.dart';
import 'package:pos/features/visits/presentation/providers/visit_form_provider.dart';

class VisitScreen extends ConsumerStatefulWidget {
  final ScanQrEntity? scanQrData;
  final CheckInEntity? checkInData;
  final ReportsEntity? reportData;

  const VisitScreen({super.key, this.scanQrData, this.checkInData, this.reportData});

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
      await ref.read(visitAttentionProvider.notifier).runVisitAttention(widget.scanQrData?.qrcode ?? widget.reportData?.branch?.qrcode ?? '');
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
              ref.read(visitFormProvider.notifier).reset();

              context.pushReplacement(AppConstants.checkOutRoute, extra: CheckOutRouteArgs(
                reportId: value.id ?? widget.reportData?.id ?? 0,
                branchId: widget.scanQrData?.id ?? widget.reportData?.branch?.id ?? 0,
                branchName: widget.scanQrData?.name ?? widget.reportData?.branch?.name ?? '-',
              ));
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
            onConfirm: () => context.goNamed('history_report'),
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
                onConfirm: () => context.goNamed('history_report'),
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
              child: AppAlertCard(
                title: 'Cabang',
                message: widget.scanQrData?.name ?? widget.reportData?.branch?.name ?? '---',
                type: AlertType.custom,
                customIcon: Icons.store,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            if (isLoadingVisitAttention) ...[
              AppLoading(message: 'Memproses pengambilan data...'),
            ] else ...[
              Positioned.fill(
                child: _buildFormSection(isLoadingCheckOut: isLoadingCheckOut),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFormSection({required bool isLoadingCheckOut}) {
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
              AppAlertCard(
                title: 'Perhatian!',
                message: visitData.visitAttention?.notes ?? '--',
                type: AlertType.warning,
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
              condition: visitData.visitAttention?.conditionRightType ?? 0,
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
              condition: visitData.visitAttention?.conditionLeftType ?? 0,
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
              condition: visitData.visitAttention?.conditionBackType ?? 0,
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
              condition: visitData.visitAttention?.conditionAroundType ?? 0,
              notes: visitData.visitAttention?.conditionAroundNotes?.trim() ?? '',
              errorText: form.errors['conditionAround'],
              options: const ['Ruko Kosong', 'Sepi', 'Ramai'],
              onChanged: notifier.setConditionAround,
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
                      reportId: widget.checkInData?.id ?? widget.reportData?.id ?? 0,
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
}
