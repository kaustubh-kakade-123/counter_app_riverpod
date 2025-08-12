import '../repositories/counter_repository.dart';

class IncrementCounterUseCase {
  final CounterRepository _repository;

  IncrementCounterUseCase(this._repository);

  void call() {
    _repository.incrementCounter();
  }
}

class DecrementCounterUseCase {
  final CounterRepository _repository;

  DecrementCounterUseCase(this._repository);

  void call() {
    _repository.decrementCounter();
  }
}

class ResetCounterUseCase {
  final CounterRepository _repository;

  ResetCounterUseCase(this._repository);

  void call() {
    _repository.resetCounter();
  }
}