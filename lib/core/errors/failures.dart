abstract class Failure {
  final String message;
  const Failure(this.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure() : super('User not found');
}

class UserAlreadyExistsFailure extends Failure {
  const UserAlreadyExistsFailure() : super('User already exists with this email');
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure() : super('Invalid email or password');
}