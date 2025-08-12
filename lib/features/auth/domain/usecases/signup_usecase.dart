import 'package:counter_app_riverpod/core/errors/failures.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/utils/validators.dart';

class SignupUseCase {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // Validate inputs
    final emailError = Validators.validateEmail(email);
    if (emailError != null) {
      return Either.left(ValidationFailure(emailError));
    }

    final passwordError = Validators.validatePassword(password);
    if (passwordError != null) {
      return Either.left(ValidationFailure(passwordError));
    }

    final confirmPasswordError = Validators.validateConfirmPassword(
      password,
      confirmPassword,
    );
    if (confirmPasswordError != null) {
      return Either.left(ValidationFailure(confirmPasswordError));
    }

    return await _repository.signup(email: email, password: password);
  }
}
