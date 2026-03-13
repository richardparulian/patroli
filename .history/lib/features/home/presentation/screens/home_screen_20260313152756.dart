import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/extensions/helper_state_extension.dart';
import 'package:pos/core/extensions/result_string_extension.dart';
import 'package:pos/core/ui/buttons/app_icon_button.dart';
import 'package:pos/core/ui/dialogs/app_dialog.dart';
import 'package:pos/core/ui/images/circle_image.dart';
import 'package:pos/core/utils/screen_util.dart';
import 'package:pos/features/auth/presentation/providers/auth_logout_provider.dart';
import 'package:pos/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:pos/features/home/widgets/error_dashboard.dart';
import 'package:pos/features/home/widgets/shimmer_dashboard.dart';
import 'package:pos/features/home/widgets/summary_dashboard.dart';
import 'package:pos/features/home/widgets/theme_toggle_switch.dart';
import 'package:pos/features/reports/presentation/providers/reports_count_provider.dart';

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
            end: Alignment.bottomRight,
            colors: [color.primary, color.primaryContainer],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/logos/pgi-horizontal-white.webp', width: 120),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.shade200,
                          child: ClipOval(
                            child: CircleImages(
                              name: userSession?.name ?? 'Security Patrol',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sistem Patroli Keamanan',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: color.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Kontrol dan pelaporan kondisi cabang',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: color.onPrimary.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
              onRefresh: () => Future.sync(() => ref.read(countReportsProvider.notifier).fetchCount()), 
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: color.surface,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text('Halo, ${(userSession?.name.firstNameSecondName) ?? '---'}',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      color: color.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const ThemeToggleSwitch(),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: countReports.isError ? color.error.withValues(alpha: 0.5) : color.primaryContainer,
                                borderRadius: BorderRadius.circular(20),
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
                            const SizedBox(height: 25),
                            _buildMenuCard(context,
                              title: 'Tambah Laporan',
                              subtitle: 'Buat laporan patroli',
                              icon: Iconsax.scan,
                              onTap: () => context.push(AppConstants.scanQrRoute),
                            ),
                            const SizedBox(height: 10),
                            _buildMenuCard(
                              context,
                              title: 'Daftar Laporan',
                              subtitle: 'Lihat laporan yang telah dibuat',
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
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        color: Theme.of(context).colorScheme.surface,
        child: AppIconButton(
          onPressed: isLoading ? null : () async {
            await AppDialog.showLogoutConfirm(
              context: context,
              onConfirm: () async {
                await ref.read(authLogoutProvider.notifier).runLogout();
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
          ) : const Icon(Iconsax.logout),
          label: 'Keluar',
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
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        leading: Icon(icon, color: color.primary),
        title: Text(title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Iconsax.arrow_right_3, size: 16, color: color.outline),
      ),
    );
  }
}