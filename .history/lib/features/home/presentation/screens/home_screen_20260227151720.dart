import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/ui/animation/animated_card.dart';
import 'package:pos/core/ui/buttons/app_button.dart';
import 'package:pos/core/ui/images/circle_image.dart';
import 'package:pos/features/auth/presentation/controllers/auth_controller.dart';
import 'package:pos/main.dart';

// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final homeState = ref.watch(homeControllerProvider);
//     final authAsync = ref.watch(authProvider);

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF134284),
//               Color(0xFF1B5CB8),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SafeArea(
//               bottom: false,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Image.asset('assets/images/logos/pgi-horizontal-white.webp', width: 120),
//                         CircleAvatar(
//                           radius: 20,
//                           backgroundColor: Colors.grey.shade200,
//                           child: ClipOval(
//                             child: CircleImages(
//                               name: 'John Doe',
//                               profile: '',
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     Text('Sistem Patroli Keamanan',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text('Kontrol dan pelaporan kondisi cabang',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(20),
//                 decoration: const BoxDecoration(
//                   color: Color(0xffF4F6FA),
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(30),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     _summaryCard(),
//                     const SizedBox(height: 25),
//                     _menuCard(
//                       title: 'Tambah Laporan',
//                       subtitle: 'Buat laporan patroli',
//                       icon: Iconsax.scan,
//                       onTap: () {},
//                     ),
//                     const SizedBox(height: 20),
//                     _menuCard(
//                       title: 'Daftar Laporan',
//                       subtitle: 'Lihat laporan yang telah dibuat',
//                       icon: Iconsax.document_text_1,
//                       onTap: () {},
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Expanded(
//               child: AppButton(
//                 label: 'Ganti Tema',
//                 fontSize: 16,
//                 onPressed: () {
//                   final themeMode = ref.watch(themeModeProvider);
//                   ref.read(themeModeProvider.notifier).set(
//                     themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
//                   );
//                 },
//                 icon: const Icon(Iconsax.moon, color: Colors.white),
//               ),
//             ),
//             const SizedBox(width: 15),
//             AppButton(
//               label: authAsync.isLoading ? null : 'Keluar',
//               fontSize: 16,
//               onPressed: authAsync.isLoading ? null : () async => await ref.read(authProvider.notifier).logout(),
//               icon: authAsync.isLoading ? const CircularProgressIndicator.adaptive(backgroundColor: Colors.white) : const Icon(Iconsax.logout, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _summaryCard() {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: AppConstants.primaryColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: AppConstants.primaryColor.withValues(alpha: 0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           )
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: const [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Total Laporan',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.white70,
//                 ),
//               ),
//               SizedBox(height: 6),
//               Text('12',
//                 style: TextStyle(
//                   fontSize: 28,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           Icon(Iconsax.chart_square5, color: Colors.white, size: 36),
//         ],
//       ),
//     );
//   }

//   Widget _menuCard({required String title, required String subtitle, required IconData icon, required VoidCallback onTap}) {
//     return AnimatedMenuCard(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 12,
//               offset: const Offset(0, 6),
//               color: Colors.black.withValues(alpha: 0.04),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               height: 55,
//               width: 55,
//               decoration: BoxDecoration(
//                 color: AppConstants.primaryColor.withValues(alpha: 0.1),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Icon(icon, color: AppConstants.primaryColor, size: 28),
//             ),
//             const SizedBox(width: 18),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(subtitle,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(Iconsax.arrow_right_3, size: 16, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
                        Image.asset(
                          'assets/images/logos/pgi-horizontal-white.webp',
                          width: 120,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: color.surface,
                          child: const Icon(Iconsax.user),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Sistem Patroli Keamanan',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: color.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Kontrol dan pelaporan kondisi cabang',
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
                  ref.read(themeModeProvider.notifier).set(
                    current == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light,
                  );
                },
                icon: const Icon(Iconsax.moon),
                label: const Text('Ganti Tema'),
              ),
            ),
            const SizedBox(width: 15),
            FilledButton.icon(
              onPressed: authAsync.isLoading
                  ? null
                  : () async =>
                      await ref.read(authProvider.notifier).logout(),
              icon: authAsync.isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Iconsax.logout),
              label: const Text('Keluar'),
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
              Text(
                'Total Laporan',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: color.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '12',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color.onPrimaryContainer,
                ),
              ),
            ],
          ),
          Icon(
            Iconsax.chart_square5,
            color: color.onPrimaryContainer,
            size: 36,
          ),
        ],
      ),
    );
  }

  Widget _menuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
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
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(
          Iconsax.arrow_right_3,
          size: 16,
          color: color.outline,
        ),
      ),
    );
  }
}