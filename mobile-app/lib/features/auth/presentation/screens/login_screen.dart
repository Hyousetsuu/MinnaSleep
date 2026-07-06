import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/widgets/neo_button.dart';
import '../../../../core/widgets/neo_text_field.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_divider.dart';
import '../widgets/social_login_button.dart';
import '../widgets/password_text_field.dart';
import '../widgets/form_section.dart';
import '../providers/login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      ref.read(loginProvider.notifier).login(
            _emailController.text.trim(),
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    final loginState = ref.watch(loginProvider);

    // Show error if login fails
    ref.listen<AsyncValue<void>>(loginProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${next.error}', style: TextStyle(color: theme.textPrimary)),
            backgroundColor: theme.surface,
            shape: Border(top: theme.defaultBorderSide),
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const AuthHeader(
                title: 'Welcome Back',
                subtitle: 'Ready to track your sleep tonight?',
                emoji: '👋',
              ),
              
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormSection(
                      label: 'Email Address',
                      child: NeoTextField(
                        hintText: 'john@example.com',
                        controller: _emailController,
                        validator: Validators.email,
                      ),
                    ),
                    FormSection(
                      label: 'Password',
                      child: PasswordTextField(
                        controller: _passwordController,
                        validator: Validators.password,
                      ),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (val) {
                                setState(() => _rememberMe = val ?? false);
                              },
                              activeColor: theme.primary,
                              checkColor: theme.textPrimary,
                              side: theme.defaultBorderSide,
                            ),
                            Text(
                              'Remember Me',
                              style: TextStyle(
                                color: theme.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => context.push(RoutePaths.forgotPassword),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: theme.primary,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    NeoButton(
                      text: loginState.isLoading ? 'Logging in...' : 'Login',
                      onPressed: loginState.isLoading ? () {} : _handleLogin,
                    ),
                  ],
                ),
              ),
              
              const AuthDivider(),
              
              SocialLoginButton(
                text: 'Continue with Google',
                icon: const Icon(LucideIcons.chrome), // Placeholder for google icon
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Google Sign-In coming soon!')),
                  );
                },
              ),
              
              const SizedBox(height: 32),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: theme.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push(RoutePaths.register),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: theme.primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
