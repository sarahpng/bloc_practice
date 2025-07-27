import 'package:bloc_practice/bloc/counter/counter_bloc.dart';
import 'package:bloc_practice/bloc/counter/counter_event.dart';
import 'package:bloc_practice/bloc/counter/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late CounterBloc _counterBloc;

  @override
  void initState() {
    _counterBloc = CounterBloc();
    super.initState();
  }

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _counterBloc,
      child: Scaffold(
        appBar: AppBar(title: Text('counter')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  state.counter.toString(),
                  style: TextStyle(fontSize: 60),
                );
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<CounterBloc, CounterState>(
                  buildWhen: (previous, current) => false,
                  builder:
                      (context, state) => ElevatedButton(
                        onPressed: () {
                          context.read<CounterBloc>().add(IncrementCounter());
                        },
                        child: Text('Increment'),
                      ),
                ),
                SizedBox(width: 20),
                BlocBuilder<CounterBloc, CounterState>(
                  buildWhen: (previous, current) => false,
                  builder:
                      (context, state) => ElevatedButton(
                        onPressed: () {
                          context.read<CounterBloc>().add(DecrementCounter());
                        },
                        child: Text('decrement'),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
