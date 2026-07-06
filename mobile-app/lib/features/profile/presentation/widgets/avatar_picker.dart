import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_shadows.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AvatarPicker extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onTap;

  const AvatarPicker({
    Key? key,
    this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.border,
                  width: 3.0,
                ),
                boxShadow: [theme.defaultShadow],
                image: imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(imageUrl!), // In real app use CachedNetworkImage
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: imageUrl == null
                  ? Icon(
                      LucideIcons.user,
                      size: 60,
                      color: theme.textSecondary,
                    )
                  : null,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: theme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.border,
                  width: 2.0,
                ),
              ),
              child: Icon(
                LucideIcons.camera,
                size: 20,
                color: theme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
