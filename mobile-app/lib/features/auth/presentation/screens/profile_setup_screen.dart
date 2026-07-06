import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../core/widgets/neo_button.dart';
import '../../../../core/widgets/neo_text_field.dart';
import '../../../../core/utils/validators.dart';
import '../../profile/presentation/widgets/avatar_picker.dart';
import '../widgets/auth_header.dart';
import '../widgets/form_section.dart';
import '../providers/profile_setup_provider.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _sleepGoalController = TextEditingController(text: '8'); // hours
  final _bedtimeGoalController = TextEditingController(text: '22:30');
  final _wakeupGoalController = TextEditingController(text: '06:30');
  
  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    _sleepGoalController.dispose();
    _bedtimeGoalController.dispose();
    _wakeupGoalController.dispose();
    super.dispose();
  }

  void _handleSetup() {
    if (_formKey.currentState!.validate()) {
      ref.read(profileSetupProvider.notifier).submitProfile(
        username: 'placeholder', // might not be needed if handled in register
        displayName: _displayNameController.text.trim(),
        bio: _bioController.text.trim(),
        sleepGoal: _sleepGoalController.text.trim(),
        bedtimeGoal: _bedtimeGoalController.text.trim(),
        wakeupGoal: _wakeupGoalController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<NeoThemeExtension>()!;
    final setupState = ref.watch(profileSetupProvider);

    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthHeader(
                title: 'Set Up Profile',
                subtitle: 'Let\'s personalize your sleep experience.',
                emoji: '🎨',
              ),
              
              AvatarPicker(
                imageUrl: setupState.avatarUrl, // if already has one
                onTap: () {
                  // In real app use image_picker to get a File, then:
                  // ref.read(profileSetupProvider.notifier).selectImage(file);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Image picker mocked')),
                  );
                },
              ),
              const SizedBox(height: 32),
              
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    FormSection(
                      label: 'Display Name',
                      child: NeoTextField(
                        hintText: 'John Doe',
                        controller: _displayNameController,
                        validator: (val) => Validators.requiredField(val, 'Display Name'),
                      ),
                    ),
                    FormSection(
                      label: 'Bio (Optional)',
                      child: NeoTextField(
                        hintText: 'I love sleeping...',
                        controller: _bioController,
                      ),
                    ),
                    
                    // Sleep Goals section
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(thickness: 2),
                    ),
                    Text(
                      'Sleep Goals',
                      style: TextStyle(
                        color: theme.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: FormSection(
                            label: 'Bedtime',
                            child: NeoTextField(
                              hintText: '22:30',
                              controller: _bedtimeGoalController,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FormSection(
                            label: 'Wake Up',
                            child: NeoTextField(
                              hintText: '06:30',
                              controller: _wakeupGoalController,
                            ),
                          ),
                        ),
                      ],
                    ),
                    FormSection(
                      label: 'Sleep Goal (Hours)',
                      child: NeoTextField(
                        hintText: '8',
                        controller: _sleepGoalController,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              NeoButton(
                text: setupState.isLoading ? 'Saving...' : 'Complete Setup',
                onPressed: setupState.isLoading ? () {} : _handleSetup,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
