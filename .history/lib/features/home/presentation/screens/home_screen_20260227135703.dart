import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/theme/app_theme.dart';
import 'package:pos/core/providers/theme_provider.dart';
import 'package:pos/core/ui/animation/animated_card.dart';
import 'package:pos/core/ui/buttons/app_button.dart';
import 'package:pos/core/ui/images/circle_image.dart';
import 'package:pos/features/home/presentation/controllers/home_controller.dart';
import 'package:pos/features/auth/presentation/controllers/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? const [
                    Color(0xFF134284),
                    Color(0xFF0D1B36),
                  ]
                : const [
                    Color(0xFF134284),
                    Color(0xFF1B5CB8),
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
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/logos/pgi-horizontal-white.webp', width: 120),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                          child: ClipOval(
                            child: CircleImages(
                              name: 'John Doe',
                              profile: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('Sistem Patroli Keamanan',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Kontrol dan pelaporan kondisi cabang',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A1F2A) : const Color(0xffF4F6FA),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    _summaryCard(isDark: isDark),
                    const SizedBox(height: 25),
                    _menuCard(
                      context: context,
                      title: 'Tambah Laporan',
                      subtitle: 'Buat laporan patroli',
                      icon: Iconsax.scan,
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    _menuCard(
                      context: context,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Ganti Tema',
                fontSize: 16,
                backgroundColor: isDark 
                    ? Colors.grey.shade800 
                    : theme.colorScheme.secondary,
                onPressed: () {
                  ref.read(main.themeModeProvider.notifier).set(
                    isDark ? ThemeMode.light : ThemeMode.dark,
                  );
                },
                icon: Icon(
                  isDark ? Iconsax.sun : Iconsax.moon,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 15),
            AppButton(
              label: authAsync.isLoading ? null : 'Keluar',
              fontSize: 16,
              onPressed: authAsync.isLoading ? null : () async => await ref.read(authProvider.notifier).logout(),
              icon: authAsync.isLoading 
                  ? const CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ) 
                  : const Icon(Iconsax.logout, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard({required bool isDark}) {
    final primaryColor = AppConstants.primaryColor;
    
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Laporan',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 6),
              Text('12',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Icon(Iconsax.chart_square5, color: Colors.white, size: 36),
        ],
      ),
    );
  }

  Widget _menuCard({
    required String title, 
    required String subtitle, 
    required IconData icon, 
    required VoidCallback onTap, 
    required BuildContext context
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = AppConstants.primaryColor;

    return AnimatedMenuCard(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 6),
              color: isDark 
                  ? Colors.black.withValues(alpha: 0.6) 
                  : Colors.black.withValues(alpha: 0.04),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.black87 : Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Iconsax.arrow_right_3, 
              size: 16, 
              color: isDark ? Colors.white70 : Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
