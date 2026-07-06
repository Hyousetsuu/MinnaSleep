import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/repositories/auth_repository.dart';
import 'auth_provider.dart';

class ProfileSetupState {
  final bool isLoading;
  final String? error;
  final String? avatarUrl;
  final File? selectedImage;

  ProfileSetupState({
    this.isLoading = false,
    this.error,
    this.avatarUrl,
    this.selectedImage,
  });

  ProfileSetupState copyWith({
    bool? isLoading,
    String? error,
    String? avatarUrl,
    File? selectedImage,
  }) {
    return ProfileSetupState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}

class ProfileSetupNotifier extends StateNotifier<ProfileSetupState> {
  final AuthRepository _authRepository;
  final AuthNotifier _authNotifier;

  ProfileSetupNotifier(this._authRepository, this._authNotifier) : super(ProfileSetupState());

  void selectImage(File image) {
    state = state.copyWith(selectedImage: image);
  }

  Future<void> submitProfile({
    required String username,
    required String displayName,
    required String bio,
    required String sleepGoal,
    required String bedtimeGoal,
    required String wakeupGoal,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      String? uploadedAvatarUrl;
      if (state.selectedImage != null) {
        uploadedAvatarUrl = await _authRepository.uploadAvatar(state.selectedImage!);
      }

      // Here you would call ProfileApi to save the profile.
      // For now, we mock success.
      await Future.delayed(const Duration(seconds: 2));

      // After success, transition state to fully authenticated
      // Assuming session manager already has the token
      _authNotifier.checkSession(); // This will re-evaluate and put us in Authenticated
      
      state = state.copyWith(isLoading: false, avatarUrl: uploadedAvatarUrl);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final profileSetupProvider = StateNotifierProvider<ProfileSetupNotifier, ProfileSetupState>((ref) {
  return ProfileSetupNotifier(
    ref.watch(authRepositoryProvider),
    ref.watch(authProvider.notifier),
  );
});
