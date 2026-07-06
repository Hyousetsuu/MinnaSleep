import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/neo_button.dart';
import '../../../../core/router/route_paths.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ActiveSleepScreen extends StatefulWidget {
  const ActiveSleepScreen({Key? key}) : super(key: key);

  @override
  State<ActiveSleepScreen> createState() => _ActiveSleepScreenState();
}

class _ActiveSleepScreenState extends State<ActiveSleepScreen> {
  late DateTime _startTime;
  late Timer _timer;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsed = DateTime.now().difference(_startTime);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _handleWakeUp() {
    // Stop background service, update Drift, calculate score, then go to summary
    // For now, mock navigation to a dummy summary dialog or dashboard
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final theme = Theme.of(context).extension<NeoThemeExtension>()!;
        return AlertDialog(
          backgroundColor: theme.background,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: theme.border, width: 3),
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Sleep Summary', style: AppTypography.heading2.copyWith(color: theme.textPrimary)),
          content: Text(
            'You slept for ${_formatDuration(_elapsed)}.\nData saved to local storage.',
            style: AppTypography.body.copyWith(color: theme.textSecondary),
          ),
          actions: [
            NeoButton(
              text: 'Go to Dashboard',
              onPressed: () {
                context.go(RoutePaths.dashboard);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    
    // Neo Brutalism Active Sleep UI (Darker, Minimalist, Bold)
    return Scaffold(
      backgroundColor: Colors.black, // Force pure black for sleep screen to save battery
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.moon, color: theme.primary, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'SLEEP TRACKING ACTIVE',
                    style: TextStyle(
                      color: theme.primary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Timer Display
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border.all(color: theme.primary, width: 4),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: theme.primary.withOpacity(0.5),
                            offset: const Offset(8, 8),
                          ),
                        ],
                      ),
                      child: Text(
                        _formatDuration(_elapsed),
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                          color: theme.textPrimary,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    
                    // Status / Confidence Mock
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.activity, color: theme.secondary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Detecting Motion...',
                          style: TextStyle(color: theme.textSecondary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Wake Up Button
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: GestureDetector(
                onTap: _handleWakeUp,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  decoration: BoxDecoration(
                    color: theme.secondary, // Magenta purple
                    border: Border.all(color: Colors.white, width: 4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(LucideIcons.sun, color: Colors.white, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        'WAKE UP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
