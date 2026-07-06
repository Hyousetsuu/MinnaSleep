import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_typography.dart';
import 'developer_panel_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Settings', style: AppTypography.h2),
        backgroundColor: AppColors.primary,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(color: AppColors.text, height: 3),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Preferences'),
          _buildListTile(Icons.palette, 'Theme & Appearance'),
          _buildListTile(Icons.language, 'Language (Bahasa)'),
          
          const SizedBox(height: 24),
          _buildSectionTitle('Sleep Config'),
          _buildListTile(Icons.bedtime, 'Sleep Goal & Bedtime'),
          _buildListTile(Icons.notifications_active, 'Notification Preferences'),
          
          const SizedBox(height: 24),
          _buildSectionTitle('Account & Data'),
          _buildListTile(Icons.privacy_tip, 'Privacy Settings'),
          _buildListTile(Icons.cloud_download, 'Backup & Restore'),
          _buildListTile(Icons.logout, 'Logout', isDestructive: true),
          
          const SizedBox(height: 48),
          _buildDeveloperModeHook(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: AppTypography.h3.copyWith(color: AppColors.text.withOpacity(0.6))),
    );
  }

  Widget _buildListTile(IconData icon, String title, {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: AppDecorations.neoBox(color: AppColors.surface),
      child: ListTile(
        leading: Icon(icon, color: isDestructive ? AppColors.warning : AppColors.text),
        title: Text(title, style: AppTypography.body),
        trailing: const Icon(Icons.chevron_right, color: AppColors.text),
        onTap: () {},
      ),
    );
  }

  Widget _buildDeveloperModeHook(BuildContext context) {
    // Hidden entry point or bottom link for dev mode
    return GestureDetector(
      onLongPress: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const DeveloperPanelScreen()));
      },
      child: Center(
        child: Text(
          'App Version 1.0.0-dev\nLong press to open Developer Panel',
          textAlign: TextAlign.center,
          style: AppTypography.caption,
        ),
      ),
    );
  }
}
