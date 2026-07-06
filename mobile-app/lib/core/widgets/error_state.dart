import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme_extension.dart';
import '../theme/app_typography.dart';
import '../constants/app_messages.dart';
import 'neo_button.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NeoErrorState extends StatelessWidget {
  final bool isNetworkError;
  final VoidCallback onRetry;

  const NeoErrorState({
    Key? key,
    this.isNetworkError = false,
    required this.onRetry,
  }) : super(key: key);

  String _getRandomUnexpectedErrorTitle() {
    final titles = [
      AppMessages.unexpectedErrorTitle1,
      AppMessages.unexpectedErrorTitle2,
      AppMessages.unexpectedErrorTitle3,
      AppMessages.unexpectedErrorTitle4,
    ];
    return titles[Random().nextInt(titles.length)];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    final title = isNetworkError ? AppMessages.networkErrorTitle : _getRandomUnexpectedErrorTitle();
    final body = isNetworkError ? AppMessages.networkErrorBody : AppMessages.unexpectedErrorBody;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: theme.error,
            border: Border.all(color: theme.border, width: 4),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [theme.defaultShadow],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isNetworkError ? LucideIcons.wifiOff : LucideIcons.bug,
                size: 64,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTypography.heading2.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                body,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              NeoButton(
                text: 'TRY AGAIN',
                onPressed: onRetry,
                // backgroundColor: Colors.white,
                // textColor: theme.error,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
