import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/services/developer_hooks.dart';

class DeveloperPanelScreen extends StatelessWidget {
  const DeveloperPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final devTools = DeveloperToolsImpl(); // Should be injected

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Developer Panel', style: AppTypography.h2),
        backgroundColor: AppColors.warning, // Warning color to signify dev mode
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(color: AppColors.text, height: 3),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDevAction(
            'Generate Dummy Sleep Data', 
            'Creates 30 days of mock data', 
            Icons.data_usage,
            () => devTools.generateDummySleepData(),
          ),
          _buildDevAction(
            'Reset User XP & Badges', 
            'Wipes all progression', 
            Icons.refresh,
            () => devTools.resetUserXpAndBadges(),
          ),
          _buildDevAction(
            'Trigger Fake Sync Conflict', 
            'Injects a conflict into Sync Queue', 
            Icons.sync_problem,
            () => devTools.triggerFakeSyncConflict(),
          ),
          _buildDevAction(
            'Force Premium Status (ON)', 
            'Simulate active subscription', 
            Icons.star,
            () => devTools.simulatePremium(true),
          ),
          _buildDevAction(
            'Clear Local Database', 
            'Wipes Drift DB entirely (Requires Advanced)', 
            Icons.delete_forever,
            () => devTools.resetDatabase(),
            isDestructive: true,
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Export & Backup'),
          _buildDevAction(
            'Export System Logs', 
            'Save logs as CSV', 
            Icons.file_download,
            () => devTools.exportLogs(),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Worker Health'),
          _buildWorkerStatusTile('Sleep Tracker', 'Running', Colors.green),
          _buildWorkerStatusTile('Sync Queue', 'Idle', Colors.grey),
          _buildWorkerStatusTile('Report Gen', 'Retrying (Network)', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: AppTypography.h3),
    );
  }

  Widget _buildWorkerStatusTile(String name, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: AppDecorations.neoBox(color: AppColors.surface),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: AppTypography.body),
          Row(
            children: [
              Icon(Icons.circle, color: color, size: 12),
              const SizedBox(width: 8),
              Text(status, style: AppTypography.caption),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDevAction(String title, String subtitle, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: AppDecorations.neoBox(color: isDestructive ? Colors.redAccent.withOpacity(0.3) : AppColors.secondary),
      child: ListTile(
        leading: Icon(icon, color: AppColors.text),
        title: Text(title, style: AppTypography.h3),
        subtitle: Text(subtitle, style: AppTypography.caption),
        onTap: () {
          onTap();
          // Ideally show a snackbar confirmation here
        },
      ),
    );
  }
}
