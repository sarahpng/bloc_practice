import 'package:bloc_practice/bloc/switch/switch_bloc.dart';
import 'package:bloc_practice/bloc/switch/switch_event.dart';
import 'package:bloc_practice/bloc/switch/switch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchExampleScreen extends StatefulWidget {
  const SwitchExampleScreen({super.key});

  @override
  State<SwitchExampleScreen> createState() => _SwitchExampleScreenState();
}

class _SwitchExampleScreenState extends State<SwitchExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Switch Example')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SwitchBloc, SwitchState>(
            buildWhen:
                (previous, current) => previous.isSwitch != current.isSwitch,
            builder: (context, state) {
              return Switch(
                value: state.isSwitch,
                onChanged: (value) {
                  context.read<SwitchBloc>().add(
                    EnableOrDisableNotifications(),
                  );
                },
              );
            },
          ),
          SizedBox(height: 20),

          BlocBuilder<SwitchBloc, SwitchState>(
            buildWhen: (previous, current) => previous.slider != current.slider,
            builder: (context, state) {
              return Container(
                height: 200,
                color: Colors.red.withOpacity(state.slider),
              );
            },
          ),

          SizedBox(height: 20),

          BlocBuilder<SwitchBloc, SwitchState>(
            buildWhen: (previous, current) => previous.slider != current.slider,
            builder: (context, state) {
              return Slider(
                value: state.slider,
                onChanged: (value) {
                  context.read<SwitchBloc>().add(SliderEvent(slider: value));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
