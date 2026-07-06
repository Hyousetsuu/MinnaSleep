import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/widgets/neo_button.dart';
import '../../../../core/widgets/neo_text_field.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/auth_header.dart';
import '../widgets/form_section.dart';
import '../widgets/password_text_field.dart';
import '../widgets/password_strength_indicator.dart';
import '../widgets/terms_checkbox.dart';
import '../providers/register_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;
  String _currentPassword = '';

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the Terms of Service')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      ref.read(registerProvider.notifier).register(
            fullName: _fullNameController.text.trim(),
            username: _usernameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    final registerState = ref.watch(registerProvider);

    ref.listen<AsyncValue<void>>(registerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${next.error}', style: TextStyle(color: theme.textPrimary)),
            backgroundColor: theme.surface,
          ),
        );
      } else if (next is AsyncData && previous is AsyncLoading) {
        // Go to email verification or directly to profile setup
        context.push(RoutePaths.profileSetup); // according to router guard this might happen automatically, but explicit is fine
      }
    });

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthHeader(
                title: 'Create Account',
                subtitle: 'Join us and start tracking your sleep journey.',
                emoji: '🌟',
              ),
              
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormSection(
                      label: 'Full Name',
                      child: NeoTextField(
                        hintText: 'John Doe',
                        controller: _fullNameController,
                        validator: (val) => Validators.requiredField(val, 'Full Name'),
                      ),
                    ),
                    FormSection(
                      label: 'Username',
                      child: NeoTextField(
                        hintText: 'johndoe99',
                        controller: _usernameController,
                        validator: Validators.username,
                      ),
                    ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          PasswordTextField(
                            controller: _passwordController,
                            validator: Validators.password,
                            onChanged: (val) {
                              setState(() {
                                _currentPassword = val;
                              });
                            },
                          ),
                          PasswordStrengthIndicator(password: _currentPassword),
                        ],
                      ),
                    ),
                    FormSection(
                      label: 'Confirm Password',
                      child: PasswordTextField(
                        hintText: 'Confirm Password',
                        controller: _confirmPasswordController,
                        validator: (val) => Validators.confirmPassword(val, _passwordController.text),
                      ),
                    ),
                    
                    TermsCheckbox(
                      value: _agreedToTerms,
                      onChanged: (val) {
                        setState(() => _agreedToTerms = val ?? false);
                      },
                    ),
                    const SizedBox(height: 32),
                    
                    NeoButton(
                      text: registerState.isLoading ? 'Creating Account...' : 'Sign Up',
                      onPressed: registerState.isLoading ? () {} : _handleRegister,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: theme.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pop(), // Back to login
                    child: Text(
                      'Login',
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
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
