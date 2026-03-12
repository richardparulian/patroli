import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pos/core/storage/cache/cache_manager.dart';

class ImagePreviewScreen extends ConsumerWidget {
  final String? imageUrl;
  final String? title;

  const ImagePreviewScreen({super.key, this.imageUrl, this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoView(
            imageProvider: CachedNetworkImageProvider('https://pgi-patroli-lebaran.s3.ap-southeast-3.amazonaws.com/production/2026_03_12/reports/f607a0da-947b-4cf0-acea-e13c51cc0755_64dc92fb-1577-4f32-b579-63c6531d9bc2_1773303296779.jpg',
              cacheManager: AppCacheManager.instance,
            ),
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
          ),

          /// TOP BAR
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),

                  if (title != null) ...[
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text('Image Detail',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}