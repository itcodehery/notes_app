import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';

class NoteAppBar extends StatelessWidget {
  const NoteAppBar({
    super.key,
    required this.widget,
  });

  final MyHomePage widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          icon: const Icon(Icons.add),
        ),
      ],
      // search bar
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search in your notes'),
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
          ),
        ),
      ),
    );
  }
}
