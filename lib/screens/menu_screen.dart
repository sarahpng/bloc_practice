import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc Examples')),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/counter'),
            child: Card(
              child: ListTile(
                title: Text('Counter Example'),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/switch'),
            child: Card(
              child: ListTile(
                title: Text('Multi States Example'),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/imagePicker'),
            child: Card(
              child: ListTile(
                title: Text('Image Picker Example'),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/todo'),
            child: Card(
              child: ListTile(
                title: Text('Todo Example'),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/favouriteApp'),
            child: Card(
              child: ListTile(
                title: Text('Favourite App Example'),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
