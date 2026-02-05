import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osoul_x_psm/core/localization/01_translation_keys.dart';

class NoItemsWidget extends StatelessWidget {
  final String? assetPath;
  final String? title;
  final String? subtitle;

  const NoItemsWidget({super.key, this.assetPath, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SVG Icon
          assetPath != null
              ? Image.asset(assetPath!, height: 56, width: 56)
              : Image.asset('assets/images/no_items.png', height: 56, width: 56),

          const SizedBox(height: 12),

          // Title
          Text(
            title ?? noItems.tr,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2A2F3A),
            ),
          ),

          // Subtitle → only if not null
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, height: 1.5, color: Color(0xFF70747B)),
            ),
          ],
        ],
      ),
    );
  }
}
