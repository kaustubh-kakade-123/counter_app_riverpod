import 'package:counter_app_riverpod/core/errors/failures.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_hive_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthHiveDatasource _localDataSource;
  User? _currentUser;

  AuthRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _localDataSource.getUser(email);
      if (userModel != null && userModel.password == password) {
        // Use dummy id and createdAt for compatibility
        _currentUser = User(
          id: 0,
          email: userModel.email,
          createdAt: DateTime.now(),
        );
        return Either.right(_currentUser!);
      } else {
        return Either.left(AuthFailure('Invalid email or password'));
      }
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
      final exists = await _localDataSource.userExists(email);
      if (exists) {
        return Either.left(AuthFailure('User already exists'));
      }
      final userModel = UserModel(email: email, password: password);
      await _localDataSource.addUser(userModel);
      _currentUser = User(id: 0, email: email, createdAt: DateTime.now());
      return Either.right(_currentUser!);
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
