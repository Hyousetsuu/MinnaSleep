import 'package:flutter/material.dart';
import '../widgets/neo_dialog.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DialogService {
  static Future<bool?> confirmDelete(BuildContext context, {required String title}) {
    return showDialog<bool>(
      context: context,
      builder: (context) => NeoDialog(
        title: title,
        message: 'Are you sure you want to delete this? This action cannot be undone.',
        icon: LucideIcons.trash2,
        isDestructive: true,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }

  static Future<bool?> confirmLogout(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => NeoDialog(
        title: 'Logout',
        message: 'Are you sure you want to sign out?',
        icon: LucideIcons.logOut,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => NeoDialog(
        title: 'Oops!',
        message: message,
        icon: LucideIcons.alertTriangle,
        isDestructive: true,
        confirmText: 'OK',
        onConfirm: () => Navigator.of(context).pop(),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => NeoDialog(
        title: 'Success',
        message: message,
        icon: LucideIcons.checkCircle,
        confirmText: 'Awesome!',
        onConfirm: () => Navigator.of(context).pop(),
      ),
    );
  }
}
