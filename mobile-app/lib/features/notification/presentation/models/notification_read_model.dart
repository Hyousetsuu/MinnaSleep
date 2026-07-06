import '../../domain/entities/notification_enums.dart';

class NotificationReadModel {
  // Pure UI Representation. No mapping logic here.
  final String id;
  final String title;
  final String subtitle; // e.g. snippet of body
  final bool isUnread;
  final bool showDot;
  final String formattedTime; // e.g., '10:30 AM'
  final String relativeTime; // e.g., '5 mins ago'
  final bool isToday;
  final bool isYesterday;
  final bool isPinned;
  final String iconAsset;
  final String badgeColorHex;
  final NotificationAction action;

  const NotificationReadModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.isUnread,
    required this.showDot,
    required this.formattedTime,
    required this.relativeTime,
    required this.isToday,
    required this.isYesterday,
    required this.isPinned,
    required this.iconAsset,
    required this.badgeColorHex,
    required this.action,
  });
}
