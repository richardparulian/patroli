import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/utils/screen_util.dart';

class FormSection extends ConsumerWidget {
  final String title;
  final List<Widget> children;

  const FormSection({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtil.radius(14)),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: ScreenUtil.paddingFromDesign(all: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil.sp(16),
              ),
            ),
            SizedBox(height: ScreenUtil.sh(12)),
            ...children
          ],
        ),
      ),
    );
  }
}