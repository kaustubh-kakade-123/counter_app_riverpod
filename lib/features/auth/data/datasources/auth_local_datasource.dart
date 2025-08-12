import 'dart:convert';
import 'package:counter_app_riverpod/core/errors/failures.dart';
import 'package:crypto/crypto.dart';
import '../../../../core/database/database_helper.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> signup({required String email, required String password});
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DatabaseHelper _databaseHelper;

  AuthLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final db = await _databaseHelper.database;

      final result = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
        limit: 1,
      );

      if (result.isEmpty) {
        throw const UserNotFoundFailure();
      }

      final userData = result.first;
      final storedPasswordHash = userData['password_hash'] as String;
      final inputPasswordHash = _hashPassword(password);

      if (storedPasswordHash != inputPasswordHash) {
        throw const InvalidCredentialsFailure();
      }

      return UserModel.fromMap(userData);
    } catch (e) {
      if (e is Failure) rethrow;
      throw DatabaseFailure('Failed to login: $e');
    }
  }

  @override
  Future<UserModel> signup({
    required String email,
    required String password,
  }) async {
    try {
      final db = await _databaseHelper.database;

      // Check if user already exists
      final existingUser = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
        limit: 1,
      );

      if (existingUser.isNotEmpty) {
        throw const UserAlreadyExistsFailure();
      }

      final now = DateTime.now();
      final passwordHash = _hashPassword(password);

      final userModel = UserModel(
        id: 0, // Will be assigned by database
        email: email,
        createdAt: now,
      );

      final userId = await db.insert(
        'users',
        userModel.toMapForInsert(passwordHash),
      );

      return UserModel(id: userId, email: email, createdAt: now);
    } catch (e) {
      if (e is Failure) rethrow;
      throw DatabaseFailure('Failed to create account: $e');
    }
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
