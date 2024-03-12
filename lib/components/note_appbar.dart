import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';

class NoteTopBar extends StatefulWidget {
  const NoteTopBar({
    super.key,
    required this.widget,
  });

  final MyHomePage widget;

  @override
  State<NoteTopBar> createState() => _NoteTopBarState();
}

class _NoteTopBarState extends State<NoteTopBar> {
  late int notesCount = 0;

  @override
  Widget build(BuildContext context) {
    var buttonStyle = ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        minimumSize: const MaterialStatePropertyAll(Size(175, 60)),
        elevation: const MaterialStatePropertyAll(0),
        side: const MaterialStatePropertyAll(
            BorderSide(color: Colors.black12, width: 1)),
        backgroundColor: const MaterialStatePropertyAll(Colors.black12));

    var iconButtonStyle = ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        elevation: const MaterialStatePropertyAll(1),
        minimumSize: const MaterialStatePropertyAll(Size(60, 60)));

    return Card(
      margin: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      elevation: 0,
      color: const Color.fromARGB(255, 237, 255, 207),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: iconButtonStyle,
                    child: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.black,
                    )),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {},
                    style: iconButtonStyle,
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.black,
                    )),
                const SizedBox(width: 5),
                ElevatedButton(
                    onPressed: () {},
                    style: iconButtonStyle,
                    child: const Icon(
                      Icons.settings_outlined,
                      color: Colors.black,
                    )),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Hello, Hari!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const Text(
              'You\'ve made 5 notes so far!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {},
                    child: const Text(
                      'Favorites',
                      style: TextStyle(color: Colors.black),
                    )),
                const SizedBox(width: 5),
                ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {},
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
