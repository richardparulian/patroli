import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:patroli/core/storage/cache/cache_manager.dart';
import 'package:patroli/core/utils/screen_util.dart';

class ImagePreviewScreen extends ConsumerWidget {
  final String imageUrl;
  final String? title;

  const ImagePreviewScreen({super.key, required this.imageUrl, this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) { 
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: color.surface,
        surfaceTintColor: color.surface,
        title: Text(title ?? 'Foto Detail'),
        titleTextStyle: theme.textTheme.headlineSmall?.copyWith(
          fontSize: ScreenUtil.sp(18),
          color: color.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(imageUrl,
          cacheManager: AppCacheManager.instance,
        ),
        backgroundDecoration: BoxDecoration(
          color: color.surface,
        ),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered,
      ),
    );
  }
}