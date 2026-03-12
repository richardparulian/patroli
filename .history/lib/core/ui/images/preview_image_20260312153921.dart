import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pos/core/entities/image_global_entity.dart';
import 'package:pos/core/storage/cache/cache_manager.dart';

class ImagePreviewScreen extends ConsumerWidget {
  const ImagePreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    final args = ModalRoute.of(context)?.settings.arguments as ImageRouteArgs;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.surface,
        surfaceTintColor: color.surface,
        title: Text(args.title ?? 'Image Detail'),
        titleTextStyle: theme.textTheme.titleMedium?.copyWith(
          color: color.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Stack(
        children: [
          PhotoView(
            imageProvider: CachedNetworkImageProvider(args.imageUrl ?? '',
              cacheManager: AppCacheManager.instance,
            ),
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
          ),
        ],
      ),
    );
  }
}