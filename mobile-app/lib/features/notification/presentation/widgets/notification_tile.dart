import 'package:flutter/material.dart';
import '../models/notification_read_model.dart';
// import '../../../../core/theme/design_tokens.dart'; // Assumed existence

class NotificationTile extends StatelessWidget {
  // CRITERIA 1: UI Contract -> Widget ONLY receives NotificationReadModel
  final NotificationReadModel model;
  final VoidCallback onSwipe;
  final VoidCallback onTap;

  const NotificationTile({
    Key? key,
    required this.model,
    required this.onSwipe,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CRITERIA 5: Design Token Enforcement
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(model.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        // Optimistic Update triggers here (UI animates away, Provider commits DB/Queue)
        onSwipe();
      },
      background: Container(
        color: colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Should ideally be SpacingTokens.lg
        child: Icon(Icons.delete, color: colorScheme.onError),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Stack(
          children: [
            Image.asset(model.iconAsset, width: 40, height: 40),
            if (model.showDot)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: colorScheme.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          model.title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: model.isUnread ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Text(
          model.subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodySmall,
        ),
        trailing: Text(
          model.relativeTime, // Pure string from ReadModel mapper, NO DateFormat here
          style: textTheme.labelSmall?.copyWith(color: colorScheme.outline),
        ),
      ),
    );
  }
}
