import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/app/constants/app_routes.dart';
import 'package:patroli/app/router/route_args/check_out_route_args.dart';
import 'package:patroli/core/enums/alert_type.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/ui/buttons/app_icon_button.dart';
import 'package:patroli/core/ui/cards/app_card_alert.dart';
import 'package:patroli/core/ui/dialogs/app_dialog.dart';
import 'package:patroli/core/ui/inputs/app_checkbox_group.dart';
import 'package:patroli/features/visits/presentation/widgets/app_radio_group.dart';
import 'package:patroli/l10n/l10n.dart';
import 'package:patroli/core/ui/inputs/app_text_field.dart';
import 'package:patroli/core/ui/widgets/app_loading.dart';
import 'package:patroli/core/utils/screen_util.dart';
import 'package:patroli/features/check_in/domain/entities/check_in_entity.dart';
import 'package:patroli/features/check_out/presentation/providers/check_out_flow_provider.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:patroli/features/visits/presentation/providers/visit_attention_flow_provider.dart';
import 'package:patroli/features/visits/presentation/providers/visit_flow_provider.dart';
import 'package:patroli/features/visits/presentation/providers/visit_form_provider.dart';

class VisitScreen extends ConsumerStatefulWidget {
  final ScanQrEntity? scanQrData;
  final CheckInEntity? checkInData;
  final ReportsEntity? reportData;

  const VisitScreen({
    super.key,
    this.scanQrData,
    this.checkInData,
    this.reportData,
  });

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
      await ref
          .read(visitAttentionFlowProvider.notifier)
          .fetchAttention(
            widget.scanQrData?.qrcode ??
                widget.reportData?.branch?.qrcode ??
                '',
          );
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

    final isLoadingCheckOut = ref.watch(
      checkOutFlowProvider.select((s) => s.isBusy),
    );
    final isLoadingVisitAttention = ref.watch(
      visitAttentionFlowProvider.select((s) => s.isLoading),
    );
    final isSubmittingVisit = ref.watch(
      visitFlowProvider.select((s) => s.isSubmitting),
    );

    ref.listen(visitFlowProvider.select((s) => s.submissionState), (
      previous,
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
            message: context.tr('visit_success_message'),
            buttonText: context.tr('continue'),
            barrierDismissible: false,
            onButtonPressed: () {
              ref.read(visitFormProvider.notifier).reset();

              context.pushReplacement(
                AppRoutes.checkOut,
                extra: CheckOutRouteArgs(
                  reportId: value?.id ?? widget.reportData?.id ?? 0,
                  branchId:
                      widget.scanQrData?.id ??
                      widget.reportData?.branch?.id ??
                      0,
                  branchName:
                      widget.scanQrData?.name ??
                      widget.reportData?.branch?.name ??
                      '-',
                ),
              );
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
            title: context.tr('confirmation'),
            message: context.tr('leave_page_confirmation'),
            onConfirm: () => context.goNamed('history_report'),
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside
          FocusScope.of(context).unfocus();
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
                Text(
                  context.tr('create_report'),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: ScreenUtil.sp(18),
                    color: color.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  context.tr('create_report_subtitle'),
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
                if (isLoadingVisitAttention || isLoadingCheckOut) return;

                AppDialog.showConfirm(
                  context: context,
                  title: context.tr('confirmation'),
                  message: context.tr('leave_page_confirmation'),
                  onConfirm: () => context.goNamed('history_report'),
                );
              },
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(ScreenUtil.sh(90)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil.sw(16),
                  vertical: ScreenUtil.sh(10),
                ),
                decoration: BoxDecoration(
                  color: color.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: color.outline.withValues(alpha: 0.2),
                    ),
                  ),
                ),
                child: AppAlertCard(
                  title: context.tr('branch'),
                  message:
                      widget.scanQrData?.name ??
                      widget.reportData?.branch?.name ??
                      '---',
                  type: AlertType.custom,
                  customIcon: Icons.store,
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: _buildFormSection(
                  isLoadingCheckOut: isLoadingCheckOut,
                  isSubmittingVisit: isSubmittingVisit,
                ),
              ),

              if (isLoadingVisitAttention) ...[
                AppLoading(message: context.tr('processing_fetch_data')),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection({
    required bool isLoadingCheckOut,
    required bool isSubmittingVisit,
  }) {
    final form = ref.watch(visitFormProvider);
    final notifier = ref.watch(visitFormProvider.notifier);

    String? errorTextFor(String field) {
      final errorKey = form.errorKeyFor(field);
      if (errorKey == null) return null;
      return context.tr(errorKey);
    }

    return ref
        .watch(visitAttentionFlowProvider)
        .attentionState
        .when(
          idle: () => AppLoading(message: context.tr('waiting_data')),
          loading: () =>
              AppLoading(message: context.tr('processing_fetch_data')),
          success: (visitData) {
            return RefreshIndicator(
              onRefresh: () => Future.sync(
                () => ref
                    .read(visitAttentionFlowProvider.notifier)
                    .fetchAttention(
                      widget.scanQrData?.qrcode ??
                          widget.reportData?.branch?.qrcode ??
                          '',
                    ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil.sw(16)),
                child: Column(
                  children: [
                    if (visitData.visitAttention?.requireAttentions == 1) ...[
                      SizedBox(height: ScreenUtil.sh(10)),
                      AppAlertCard(
                        title: context.tr('attention'),
                        message: visitData.visitAttention?.notes ?? '--',
                        type: AlertType.warning,
                      ),
                    ],
                    SizedBox(height: ScreenUtil.sh(10)),
                    AppRadioGroup<String>(
                      title: context.tr('banner_lights'),
                      icon: Iconsax.lamp_charge,
                      value: form.lampuBanner,
                      errorText: errorTextFor(VisitFormFields.lightsStatus),
                      options: [context.tr('on'), context.tr('off')],
                      onChanged: notifier.setLampuBanner,
                    ),
                    SizedBox(height: ScreenUtil.sh(10)),
                    AppRadioGroup<String>(
                      title: context.tr('main_banner'),
                      icon: Iconsax.image,
                      value: form.bannerUtama,
                      errorText: errorTextFor(VisitFormFields.bannerStatus),
                      options: [context.tr('good'), context.tr('damaged')],
                      onChanged: notifier.setBannerUtama,
                    ),
                    SizedBox(height: ScreenUtil.sh(10)),
                    AppRadioGroup<String>(
                      title: context.tr('rolling_door_status'),
                      icon: Icons.door_front_door,
                      value: form.rollingDoor,
                      errorText: errorTextFor(
                        VisitFormFields.rollingDoorStatus,
                      ),
                      options: [
                        context.tr('closed_tightly'),
                        context.tr('open_loose'),
                      ],
                      onChanged: notifier.setRollingDoor,
                    ),
                    SizedBox(height: ScreenUtil.sh(10)),
                    AppCheckboxGroup(
                      errorText: errorTextFor(
                        VisitFormFields.rollingDoorChecklist,
                      ),
                      options: [
                        context.tr('flashlight_checked'),
                        context.tr('knock_checked'),
                      ],
                      values: form.rollingDoorChecklist,
                      onChanged: notifier.setRollingDoorChecklist,
                    ),
                    SizedBox(height: ScreenUtil.sh(10)),
                    AppRadioGroup<String>(
                      title: context.tr('branch_condition_right'),
                      icon: Iconsax.sidebar_right,
                      value: form.conditionRight,
                      condition:
                          visitData.visitAttention?.conditionRightType ?? 0,
                      errorText: errorTextFor(VisitFormFields.conditionRight),
                      options: [context.tr('safe'), context.tr('taruna')],
                      onChanged: notifier.setConditionRight,
                    ),
                    SizedBox(height: ScreenUtil.sh(10)),
                    AppRadioGroup<String>(
                      title: context.tr('branch_condition_left'),
                      icon: Iconsax.sidebar_left,
                      value: form.conditionLeft,
                      condition:
                          visitData.visitAttention?.conditionLeftType ?? 0,
                      errorText: errorTextFor(VisitFormFields.conditionLeft),
                      options: [context.tr('safe'), context.tr('taruna')],
                      onChanged: notifier.setConditionLeft,
                    ),
                    SizedBox(height: ScreenUtil.sh(10)),
                    AppRadioGroup<String>(
                      title: context.tr('branch_condition_back'),
                      icon: Iconsax.undo,
                      value: form.conditionBack,
                      condition:
                          visitData.visitAttention?.conditionBackType ?? 0,
                      errorText: errorTextFor(VisitFormFields.conditionBack),
                      options: [context.tr('safe'), context.tr('taruna')],
                      onChanged: notifier.setConditionBack,
                    ),
                    SizedBox(height: ScreenUtil.sh(10)),
                    AppRadioGroup<String>(
                      title: context.tr('branch_condition_around'),
                      icon: Iconsax.story,
                      value: form.conditionAround,
                      errorText: errorTextFor(VisitFormFields.conditionAround),
                      options: [
                        context.tr('empty_shop'),
                        context.tr('quiet'),
                        context.tr('crowded'),
                      ],
                      onChanged: notifier.setConditionAround,
                    ),
                    SizedBox(height: ScreenUtil.sh(15)),
                    AppTextField(
                      radius: ScreenUtil.radius(16),
                      cursor: true,
                      isDense: false,
                      label: context.tr('optional_notes'),
                      hint: context.tr('notes'),
                      focusNode: noteFocusNode,
                      controller: noteController,
                      isMultiline: true,
                    ),
                    SizedBox(height: ScreenUtil.sh(20)),
                    AppIconButton(
                      label: context.tr('send'),
                      icon: isSubmittingVisit
                          ? SizedBox(
                              height: ScreenUtil.sw(14),
                              width: ScreenUtil.sw(14),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                strokeCap: StrokeCap.round,
                                color: Colors.white,
                              ),
                            )
                          : Icon(Iconsax.send_1, size: ScreenUtil.icon(18)),
                      type: IconButtonType.primary,
                      minimumSize: Size(double.infinity, ScreenUtil.sh(45)),
                      onPressed: isSubmittingVisit
                          ? null
                          : () async {
                              noteFocusNode.unfocus();

                              AppDialog.showConfirm(
                                context: context,
                                title: context.tr('confirmation'),
                                message: context.tr(
                                  'submit_report_confirmation',
                                ),
                                onConfirm: () async {
                                  await ref
                                      .read(visitFlowProvider.notifier)
                                      .submit(
                                        reportId:
                                            widget.checkInData?.id ??
                                            widget.reportData?.id ??
                                            0,
                                        notes: noteController.text.trim(),
                                      );
                                },
                              );
                            },
                    ),
                    SizedBox(height: ScreenUtil.sh(20)),
                  ],
                ),
              ),
            );
          },
          error: (msg) =>
              Center(child: Text('${context.tr('error_occurred')}: $msg')),
        );
  }
}
