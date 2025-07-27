import 'package:bloc_practice/bloc/favourite_app/favourite_app_bloc.dart';
import 'package:bloc_practice/bloc/posts/posts_bloc.dart';
import 'package:bloc_practice/constants/routes.dart';
import 'package:bloc_practice/repository/favourite_repository.dart';
import 'package:bloc_practice/repository/posts_repository.dart';
import 'package:bloc_practice/screens/counter/counter_screen.dart';
import 'package:bloc_practice/screens/favourite_app/favourite_app_screen.dart';
import 'package:bloc_practice/screens/image_picker/image_picker_screen.dart';
import 'package:bloc_practice/screens/menu_screen.dart';
import 'package:bloc_practice/screens/posts/posts_screen.dart';
import 'package:bloc_practice/screens/switch_example/switch_example_screen.dart';
import 'package:bloc_practice/screens/todo_screen/todo_screen.dart';
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
        BlocProvider(create: (_) => FavouriteAppBloc(FavouriteRepository())),
        BlocProvider(create: (_) => PostsBloc(PostRepository())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: Routes.menuScreen,
        routes: {
          Routes.menuScreen: (context) => const MenuScreen(),
          Routes.counterScreen: (context) => const CounterScreen(),
          Routes.switchScreen: (context) => const SwitchExampleScreen(),
          Routes.imagePickerScreen: (context) => const ImagePickerScreen(),
          Routes.todo: (context) => const TodoScreen(),
          Routes.favouriteApp: (context) => const FavouriteAppScreen(),
          Routes.posts: (context) => const PostsScreen(),
        },
      ),
    );
  }
}
