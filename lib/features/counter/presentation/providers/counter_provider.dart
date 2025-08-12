import 'package:counter_app_riverpod/features/counter/domain/usecases/counter_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/counter_repository.dart';
import '../../data/repositories/counter_repository_impl.dart';

// Repository provider
final counterRepositoryProvider = Provider<CounterRepository>((ref) {
  return CounterRepositoryImpl();
});

// Use case providers
final incrementCounterUseCaseProvider = Provider<IncrementCounterUseCase>((
  ref,
) {
  final repository = ref.read(counterRepositoryProvider);
  return IncrementCounterUseCase(repository);
});

final decrementCounterUseCaseProvider = Provider<DecrementCounterUseCase>((
  ref,
) {
  final repository = ref.read(counterRepositoryProvider);
  return DecrementCounterUseCase(repository);
});

final resetCounterUseCaseProvider = Provider<ResetCounterUseCase>((ref) {
  final repository = ref.read(counterRepositoryProvider);
  return ResetCounterUseCase(repository);
});

// Counter state notifier
class CounterNotifier extends StateNotifier<int> {
  final CounterRepository _repository;
  final IncrementCounterUseCase _incrementUseCase;
  final DecrementCounterUseCase _decrementUseCase;
  final ResetCounterUseCase _resetUseCase;

  CounterNotifier(
    this._repository,
    this._incrementUseCase,
    this._decrementUseCase,
    this._resetUseCase,
  ) : super(_repository.getCounter());

  void increment() {
    _incrementUseCase.call();
    state = _repository.getCounter();
  }

  void decrement() {
    _decrementUseCase.call();
    state = _repository.getCounter();
  }

  void reset() {
    _resetUseCase.call();
    state = _repository.getCounter();
  }
}

// Counter state provider
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  final repository = ref.read(counterRepositoryProvider);
  final incrementUseCase = ref.read(incrementCounterUseCaseProvider);
  final decrementUseCase = ref.read(decrementCounterUseCaseProvider);
  final resetUseCase = ref.read(resetCounterUseCaseProvider);

  return CounterNotifier(
    repository,
    incrementUseCase,
    decrementUseCase,
    resetUseCase,
  );
});
