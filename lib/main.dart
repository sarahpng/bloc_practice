import 'package:bloc_practice/bloc/counter/counter_bloc.dart';
import 'package:bloc_practice/bloc/image_picker/image_picker_bloc.dart';
import 'package:bloc_practice/bloc/switch/switch_bloc.dart';
import 'package:bloc_practice/bloc/todo/todo_bloc.dart';
import 'package:bloc_practice/screens/counter/counter_screen.dart';
import 'package:bloc_practice/screens/image_picker/image_picker_screen.dart';
import 'package:bloc_practice/screens/menu_screen.dart';
import 'package:bloc_practice/screens/switch_example/switch_example_screen.dart';
import 'package:bloc_practice/screens/todo_screen/todo_screen.dart';
import 'package:bloc_practice/utils/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => SwitchBloc()),
        BlocProvider(create: (_) => ImagePickerBloc(ImagePickerUtils())),
        BlocProvider(create: (_) => TodoBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MenuScreen(),
          '/counter': (context) => const CounterScreen(),
          '/switch': (context) => const SwitchExampleScreen(),
          '/imagePicker': (context) => const ImagePickerScreen(),
          '/todo': (context) => const TodoScreen(),
        },
      ),
    );
  }
}
