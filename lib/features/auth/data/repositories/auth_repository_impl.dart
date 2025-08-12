import 'package:counter_app_riverpod/core/errors/failures.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;
  User? _currentUser;

  AuthRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _localDataSource.login(
        email: email,
        password: password,
      );
      _currentUser = user;
      return Either.right(user);
    } on Failure catch (failure) {
      return Either.left(failure);
    } catch (e) {
      return Either.left(AuthFailure('Unexpected error during login: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> signup({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _localDataSource.signup(
        email: email,
        password: password,
      );
      _currentUser = user;
      return Either.right(user);
    } on Failure catch (failure) {
      return Either.left(failure);
    } catch (e) {
      return Either.left(AuthFailure('Unexpected error during signup: $e'));
    }
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
  }

  @override
  User? getCurrentUser() {
    return _currentUser;
  }
}
