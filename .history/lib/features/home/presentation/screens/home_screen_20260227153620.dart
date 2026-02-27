import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/ui/images/circle_image.dart';
import 'package:pos/features/auth/presentation/controllers/auth_controller.dart';
import 'package:pos/main.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final authAsync = ref.watch(authProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.primary,
              color.primaryContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                            child: CircleImages(name: authAsync.value?.name ?? 'User Patroli'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
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
            ),

            /// Bottom Section
            Expanded(
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
                  children: [
                    _summaryCard(context),
                    const SizedBox(height: 25),
                    _menuCard(
                      context,
                      title: 'Tambah Laporan',
                      subtitle: 'Buat laporan patroli',
                      icon: Iconsax.scan,
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    _menuCard(
                      context,
                      title: 'Daftar Laporan',
                      subtitle: 'Lihat laporan yang telah dibuat',
                      icon: Iconsax.document_text_1,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      /// Bottom Buttons
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () {
                  final current = ref.read(themeModeProvider);

                  ref.read(themeModeProvider.notifier).set(current == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
                },
                icon: const Icon(Iconsax.moon),
                label: const Text('Ganti Tema'),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: FilledButton.icon(
                onPressed: authAsync.isLoading ? null : () async => await ref.read(authProvider.notifier).logout(),
                icon: authAsync.isLoading ? const CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ) : const Icon(Iconsax.logout),
                label: const Text('Keluar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Laporan',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: color.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 6),
              Text('12',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color.onPrimaryContainer,
                ),
              ),
            ],
          ),
          Icon(Iconsax.chart_square5, color: color.onPrimaryContainer, size: 36),
        ],
      ),
    );
  }

  Widget _menuCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        onTap: onTap,
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