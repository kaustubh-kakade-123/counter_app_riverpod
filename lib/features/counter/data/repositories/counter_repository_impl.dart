import '../../domain/repositories/counter_repository.dart';

class CounterRepositoryImpl implements CounterRepository {
  int _counter = 0;

  @override
  int getCounter() => _counter;

  @override
  void setCounter(int value) {
    _counter = value;
  }

  @override
  void incrementCounter() {
    _counter++;
  }

  @override
  void decrementCounter() {
    _counter--;
  }

  @override
  void resetCounter() {
    _counter = 0;
  }
}
