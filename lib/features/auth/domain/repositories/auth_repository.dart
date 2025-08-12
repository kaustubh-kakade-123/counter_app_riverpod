import 'package:counter_app_riverpod/core/errors/failures.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signup({
    required String email,
    required String password,
  });

  Future<void> logout();

  User? getCurrentUser();
}

// Simple Either implementation for error handling
class Either<L, R> {
  final L? _left;
  final R? _right;

  Either.left(this._left) : _right = null;
  Either.right(this._right) : _left = null;

  bool get isLeft => _left != null;
  bool get isRight => _right != null;

  L get left => _left!;
  R get right => _right!;

  T fold<T>(T Function(L) leftFunction, T Function(R) rightFunction) {
    if (isLeft) {
      return leftFunction(_left as L);
    } else {
      return rightFunction(_right as R);
    }
  }
}
