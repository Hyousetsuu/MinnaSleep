import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/widgets/neo_button.dart';
import '../../../../core/widgets/neo_text_field.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/auth_header.dart';
import '../widgets/form_section.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleReset() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // Mock API call
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.textPrimary, size: 32),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _isSuccess ? _buildSuccess(theme) : _buildForm(theme),
        ),
      ),
    );
  }

  Widget _buildForm(NeoThemeExtension theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuthHeader(
          title: 'Reset Password',
          subtitle: 'Enter your email and we\'ll send you a reset link.',
          emoji: '🔑',
        ),
        Form(
          key: _formKey,
          child: FormSection(
            label: 'Email Address',
            child: NeoTextField(
              hintText: 'john@example.com',
              controller: _emailController,
              validator: Validators.email,
            ),
          ),
        ),
        const SizedBox(height: 24),
        NeoButton(
          text: _isLoading ? 'Sending...' : 'Send Reset Link',
          onPressed: _isLoading ? () {} : _handleReset,
        ),
      ],
    );
  }

  Widget _buildSuccess(NeoThemeExtension theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('✉️', style: TextStyle(fontSize: 100), textAlign: TextAlign.center),
        const SizedBox(height: 32),
        Text(
          'Check Your Email',
          style: TextStyle(color: theme.textPrimary, fontSize: 32, fontWeight: FontWeight.w900),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'We have sent a password reset link to ${_emailController.text}',
          style: TextStyle(color: theme.textSecondary, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        NeoButton(
          text: 'Back to Login',
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
