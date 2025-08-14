import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/datasources/auth_hive_datasource.dart';

// Data source provider (Hive)
final authHiveDataSourceProvider = Provider<AuthHiveDatasource>((ref) {
  return AuthHiveDatasource();
});

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.read(authHiveDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});

// Use case providers
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LoginUseCase(repository);
});

final signupUseCaseProvider = Provider<SignupUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return SignupUseCase(repository);
});

// Auth state notifier
class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository _authRepository;
  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;

  AuthNotifier(this._authRepository, this._loginUseCase, this._signupUseCase)
    : super(AsyncValue.data(_authRepository.getCurrentUser()));

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();

    final result = await _loginUseCase.call(email: email, password: password);

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }

  Future<void> signup({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    state = const AsyncValue.loading();

    final result = await _signupUseCase.call(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = const AsyncValue.data(null);
  }
}

// Auth state provider
final authStateProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
      final authRepository = ref.read(authRepositoryProvider);
      final loginUseCase = ref.read(loginUseCaseProvider);
      final signupUseCase = ref.read(signupUseCaseProvider);

      return AuthNotifier(authRepository, loginUseCase, signupUseCase);
    });
