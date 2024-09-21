import 'package:flutter/material.dart';
import 'package:forms_app/presentation/screen/cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: const _CubitCounterView(),
    );
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView();

  void _increment(BuildContext context, [int value = 1]) {
    context.read<CounterCubit>().increment(value);
  }

  @override
  Widget build(BuildContext context) {
    // final counterState = context.watch<CounterCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: context.select((CounterCubit counter) =>
            Text('Cubit Counter: ${counter.state.transactionCount}')),
        actions: [
          IconButton(
            onPressed: () => context.read<CounterCubit>().reset(),
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          // buildWhen: (previous, current) => previous.counter != current.counter,
          builder: (context, state) {
            return Text("counter value: ${state.counter}");
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _increment(context, 3),
            heroTag: '1',
            child: const Text("+3"),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            onPressed: () => _increment(context, 2),
            heroTag: '2',
            child: const Text("+2"),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            onPressed: () => _increment(context, 1),
            heroTag: '3',
            child: const Text("+1"),
          ),
        ],
      ),
    );
  }
}
