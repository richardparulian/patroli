import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:patroli/core/extensions/result_string_extension.dart';

String createInitial(String name) {
  String initialName = name.trim().split(RegExp(r'\s+')).map((l) => l[0]).take(2).join().toUpperCase();

  return initialName;
}

class CircleImages extends StatelessWidget {
  final String imageUrl;
  final String name;

  const CircleImages({super.key, this.imageUrl = '', required this.name});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return imageUrl.isNotEmpty ? CachedNetworkImage(
      // cacheManager: DefaultCacheManager(),
      imageUrl: imageUrl,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      placeholder: (_, _) {
        return Center(
          child: Text(name.initials,
            style: TextStyle(
              fontSize: 18.0,
              color: primaryColor,
              fontWeight: FontWeight.bold, 
            ),
          ),
        );
      },
      errorWidget: (_, _, _) {
        return Center(
          child: Text(createInitial(name),
            style: TextStyle(
              fontSize: 18.0,
              color: primaryColor,
              fontWeight: FontWeight.bold, 
            ),
          ),
        );
      },
    ) : Center(
      child: Text(createInitial(name),
        style: TextStyle(
          fontSize: 18.0,
          color: primaryColor,
          fontWeight: FontWeight.bold, 
        ),
      ),
    );
  }
}