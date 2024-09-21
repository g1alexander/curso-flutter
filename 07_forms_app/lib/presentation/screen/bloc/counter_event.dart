part of 'counter_bloc.dart';

sealed class CounterEvent {
  const CounterEvent();
}

class CounterIncrement extends CounterEvent {
  final int value;

  const CounterIncrement(this.value);
}

class CounterReset extends CounterEvent {}
