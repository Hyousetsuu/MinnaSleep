import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/widgets/neo_button.dart';
import '../widgets/auth_header.dart';
import '../../../../core/router/route_paths.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  const VerifyEmailScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool _isResending = false;

  void _handleResend() async {
    setState(() => _isResending = true);
    await Future.delayed(const Duration(seconds: 2)); // mock
    setState(() => _isResending = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verification email resent!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthHeader(
                title: 'Verify Email',
                subtitle: 'We need to verify your email address to secure your account.',
                emoji: '📬',
              ),
              const SizedBox(height: 16),
              Text(
                'A verification link has been sent to:',
                style: TextStyle(color: theme.textSecondary, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                widget.email,
                style: TextStyle(
                  color: theme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              NeoButton(
                text: 'I have verified my email',
                onPressed: () {
                  // In real app, might check state or refresh session
                  context.go(RoutePaths.profileSetup);
                },
              ),
              const SizedBox(height: 24),
              NeoButton(
                text: _isResending ? 'Resending...' : 'Resend Email',
                backgroundColor: theme.background,
                textColor: theme.textPrimary,
                onPressed: _isResending ? () {} : _handleResend,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
