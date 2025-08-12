import 'package:counter_app_riverpod/core/errors/failures.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/utils/validators.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
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

    return await _repository.login(email: email, password: password);
  }
}