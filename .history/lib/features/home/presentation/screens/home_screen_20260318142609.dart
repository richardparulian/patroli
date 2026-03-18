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
      body: ColoredBox(
        color: color.primary,
        child: RefreshIndicator(
          onRefresh: () => ref.read(countReportsProvider.notifier).fetchCount(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _HomeHeaderDelegate(
                minExtentValue: ScreenUtil.sh(112),
                maxExtentValue: ScreenUtil.sh(140),
                colorScheme: color,
                title: context.tr('security_patrol_system'),
                subtitle: context.tr('branch_control_reporting'),
                settingsTooltip: context.tr('settings'),
                profileName: userSession?.name ?? context.tr('security_patrol'),
                  onSettingsTap: () => context.push(AppRoutes.settings),
                ),
              ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: Transform.translate(
                offset: Offset(0, -ScreenUtil.sh(0)),
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
                    boxShadow: [
                      BoxShadow(
                        color: color.shadow.withValues(alpha: 0.08),
                        blurRadius: ScreenUtil.radius(18),
                        offset: Offset(0, -ScreenUtil.sh(2)),
                      ),
                    ],
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

class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  _HomeHeaderDelegate({
    required this.minExtentValue,
    required this.maxExtentValue,
    required this.colorScheme,
    required this.title,
    required this.subtitle,
    required this.settingsTooltip,
    required this.profileName,
    required this.onSettingsTap,
  });

  final double minExtentValue;
  final double maxExtentValue;
  final ColorScheme colorScheme;
  final String title;
  final String subtitle;
  final String settingsTooltip;
  final String profileName;
  final VoidCallback onSettingsTap;

  @override
  double get minExtent => minExtentValue;

  @override
  double get maxExtent => maxExtentValue;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    final progress = (shrinkOffset / (maxExtentValue - minExtentValue)).clamp(0.0, 1.0);
    final subtitleOpacity = 1 - (progress * 1.2);
    final titleSpacing = ScreenUtil.sh(4) * (1 - (progress * 0.3));
    final avatarRadius = ScreenUtil.radius(18) - (progress * ScreenUtil.radius(1.5));
    final logoWidth = ScreenUtil.sw(120) - (progress * ScreenUtil.sw(8));
    final topPadding = ScreenUtil.sh(16) - (progress * ScreenUtil.sh(2));

    return Material(
      color: colorScheme.primary,
      elevation: overlapsContent ? 2 : 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary,
              colorScheme.primaryContainer,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              ScreenUtil.sw(20),
              topPadding,
              ScreenUtil.sw(20),
              ScreenUtil.sh(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      Assets.images.logos.pgiHorizontalWhite.path,
                      width: logoWidth,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: onSettingsTap,
                          tooltip: settingsTooltip,
                          icon: Icon(
                            Iconsax.setting_2,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(width: ScreenUtil.sw(4)),
                        CircleAvatar(
                          radius: avatarRadius,
                          backgroundColor: Colors.grey.shade200,
                          child: ClipOval(
                            child: CircleImages(name: profileName),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: titleSpacing),
                Opacity(
                  opacity: subtitleOpacity.clamp(0.0, 1.0),
                  child: Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimary.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _HomeHeaderDelegate oldDelegate) {
    return minExtentValue != oldDelegate.minExtentValue ||
        maxExtentValue != oldDelegate.maxExtentValue ||
        colorScheme != oldDelegate.colorScheme ||
        title != oldDelegate.title ||
        subtitle != oldDelegate.subtitle ||
        settingsTooltip != oldDelegate.settingsTooltip ||
        profileName != oldDelegate.profileName;
  }
}
