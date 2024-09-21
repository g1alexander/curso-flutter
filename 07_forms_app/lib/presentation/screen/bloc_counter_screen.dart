import 'package:flutter/material.dart';
import 'package:forms_app/presentation/screen/bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const _BlocCounterView(),
    );
  }
}

class _BlocCounterView extends StatelessWidget {
  const _BlocCounterView();

  void _onIncrement(BuildContext context, int value) {
    // context.read<CounterBloc>().add(CounterIncrement(value));
    context.read<CounterBloc>().increase(value);
  }

  void _onReset(BuildContext context) {
    context.read<CounterBloc>().add(CounterReset());
  }

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.watch<CounterBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Counter: ${counterBloc.transactionCount}'),
        actions: [
          IconButton(
            onPressed: () => _onReset(context),
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: Center(
        child: context.select((CounterBloc counterBloc) =>
            Text("counter value: ${counterBloc.state.counter}")),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _onIncrement(context, 3),
            heroTag: '1',
            child: const Text("+3"),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            onPressed: () => _onIncrement(context, 2),
            heroTag: '2',
            child: const Text("+2"),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            onPressed: () => _onIncrement(context, 1),
            heroTag: '3',
            child: const Text("+1"),
          ),
        ],
      ),
    );
  }
}
