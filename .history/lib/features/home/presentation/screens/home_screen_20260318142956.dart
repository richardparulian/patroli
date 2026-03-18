import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/app/constants/app_routes.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/extensions/result_string_extension.dart';
import 'package:patroli/core/ui/buttons/app_icon_button.dart';
import 'package:patroli/core/ui/dialogs/app_dialog.dart';
import 'package:patroli/core/ui/images/circle_image.dart';
import 'package:patroli/core/utils/screen_util.dart';
import 'package:patroli/features/auth/application/providers/auth_session_provider.dart';
import 'package:patroli/features/auth/presentation/providers/auth_logout_provider.dart';
import 'package:patroli/features/home/widgets/error_dashboard.dart';
import 'package:patroli/features/home/widgets/shimmer_dashboard.dart';
import 'package:patroli/features/home/widgets/summary_dashboard.dart';
import 'package:patroli/features/reports/presentation/providers/reports_count_provider.dart';
import 'package:patroli/gen/assets.gen.dart';
import 'package:patroli/l10n/l10n.dart';

class HomeScreen extends ConsumerStatefulWidget { 
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(countReportsProvider.notifier).fetchCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    
    final userSession = ref.watch(authSessionProvider);
    final countReports = ref.watch(countReportsProvider);

    final isLoading = ref.watch(authLogoutProvider.select((s) => s.isLoading));


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              color.primary,
              color.primaryContainer,
            ],
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () => ref.read(countReportsProvider.notifier).fetchCount(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                expandedHeight: ScreenUtil.sh(120),
                scrolledUnderElevation: 1,
                backgroundColor: Colors.transparent,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(Assets.images.logos.pgiHorizontalWhite.path, width: ScreenUtil.sw(120)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => context.push(AppRoutes.settings),
                          tooltip: context.tr('settings'),
                          icon: Icon(
                            Iconsax.setting_2,
                            color: color.onPrimary,
                          ),
                        ),
                        SizedBox(width: ScreenUtil.sw(4)),
                        CircleAvatar(
                          radius: ScreenUtil.radius(18),
                          backgroundColor: Colors.grey.shade200,
                          child: ClipOval(
                            child: CircleImages(
                              name: userSession?.name ?? context.tr('security_patrol'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.transparent,
                    // decoration: BoxDecoration(
                    //   gradient: LinearGradient(
                    //     colors: [
                    //       color.primary,
                    //       color.primaryContainer,
                    //     ],
                    //   ),
                    // ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          ScreenUtil.sw(20),
                          ScreenUtil.sh(20),
                          ScreenUtil.sw(20),
                          ScreenUtil.sh(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(context.tr('security_patrol_system'),
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: color.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: ScreenUtil.sh(4)),
                            Text(context.tr('branch_control_reporting'),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: color.onPrimary.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.sw(20),
                    vertical: ScreenUtil.sh(10),
                  ),
                  decoration: BoxDecoration(
                    color: color.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(ScreenUtil.radius(30)),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.trParams('hello_user', {'name': (userSession?.name.firstNameSecondName) ?? '---'}),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: ScreenUtil.sh(15)),
                      Container(
                        padding: ScreenUtil.paddingFromDesign(all: 16),
                        decoration: BoxDecoration(
                          color: countReports.isError ? color.error.withValues(alpha: 0.5) : color.primaryContainer,
                          borderRadius: BorderRadius.circular(ScreenUtil.radius(20)),
                        ),
                        child: countReports.when(
                          idle: () => const SizedBox(),
                          loading: () => const ShimmerDashboard(),
                          success: (data) => SummaryDashboard(
                            totalReports: data.total,
                            byStatus: data.byStatus,
                          ),
                          error: (message) => ErrorDashboard(errorMessage: message),
                        ),
                      ),
                      SizedBox(height: ScreenUtil.sh(25)),
                      _buildMenuCard(
                        context,
                        title: context.tr('add_report'),
                        subtitle: context.tr('create_patrol_report'),
                        icon: Iconsax.scan,
                        onTap: () => context.push(AppRoutes.scanQr),
                      ),
                      SizedBox(height: ScreenUtil.sh(10)),
                      _buildMenuCard(
                        context,
                        title: context.tr('report_list'),
                        subtitle: context.tr('view_created_reports'),
                        icon: Iconsax.document_text_1,
                        onTap: () => context.goNamed('history_report'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: ScreenUtil.paddingFromDesign(all: 20),
        color: Theme.of(context).colorScheme.surface,
        child: AppIconButton(
          onPressed: isLoading ? null : () async {
            await AppDialog.showLogoutConfirm(
              context: context,
              onConfirm: () async {
                final result = await ref.read(authLogoutProvider.notifier).runLogout();
                if (!context.mounted) return;

                result.when(
                  idle: () => null,
                  loading: () => null,
                  success: (_) => context.go(AppRoutes.login),
                  error: (_) => null,
                );
              },
            );
          },
          icon: isLoading ? SizedBox(
            height: ScreenUtil.sw(14),
            width: ScreenUtil.sw(14),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              strokeCap: StrokeCap.round,
              color: Colors.white,
            ),
          ) : Icon(Iconsax.logout, size: ScreenUtil.icon(18)),
          label: context.tr('logout'),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtil.radius(20)),
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil.radius(20)),
        ),
        leading: Icon(icon, color: color.primary, size: ScreenUtil.icon(22)),
        title: Text(title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Iconsax.arrow_right_3, size: ScreenUtil.icon(16), color: color.outline),
      ),
    );
  }
}
