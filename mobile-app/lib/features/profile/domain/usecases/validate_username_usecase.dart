import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';

class ValidateUsernameUseCase {
  // Pre-defined reserved words that users cannot use
  static const List<String> _reservedWords = [
    'admin', 'support', 'root', 'system', 'api', 'premium', 'minna', 'minnasleep'
  ];

  Result<bool> execute(String username) {
    if (username.isEmpty) {
      return const Error(ValidationFailure(message: 'Username cannot be empty.'));
    }

    if (username.length < 3 || username.length > 20) {
      return const Error(ValidationFailure(message: 'Username must be between 3 and 20 characters.'));
    }

    // Regex check: Only alphanumeric and underscores
    final validCharacters = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!validCharacters.hasMatch(username)) {
      return const Error(ValidationFailure(message: 'Username can only contain letters, numbers, and underscores.'));
    }

    // Reserved words check
    if (_reservedWords.contains(username.toLowerCase())) {
      return const Error(ValidationFailure(message: 'This username is reserved and cannot be used.'));
    }

    // TODO: Remote Availability check (e.g., query database to see if it exists)
    // For now, assume it's valid locally
    return const Success(true);
  }
}
