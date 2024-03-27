import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/pages/bin.dart';
import 'package:notes_app/pages/favorites.dart';
import 'package:notes_app/pages/search.dart';
import 'package:notes_app/pages/settings.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';

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
        minimumSize: const MaterialStatePropertyAll(Size(150, 60)),
        elevation: const MaterialStatePropertyAll(0),
        side: const MaterialStatePropertyAll(
            BorderSide(color: Colors.black12, width: 2)),
        backgroundColor: const MaterialStatePropertyAll(Colors.transparent));

    var iconButtonStyle = ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        elevation: const MaterialStatePropertyAll(0),
        minimumSize: const MaterialStatePropertyAll(Size(50, 50)));
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 237, 255, 207),
          Color.fromARGB(255, 217, 255, 156),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      // margin: const EdgeInsets.all(0),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(40),
      //     bottomRight: Radius.circular(40),
      //   ),
      // ),
      // elevation: 0,
      // color: const Color.fromARGB(255, 237, 255, 207),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Provider.of<NoteProvider>(context, listen: false)
                          .refresh();
                    },
                    style: iconButtonStyle,
                    child: const Icon(
                      Icons.refresh,
                      size: 20,
                      color: Colors.black,
                    )),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const DeletedNotesPage(),
                        ),
                      );
                    },
                    style: iconButtonStyle,
                    child: const Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: Colors.black,
                    )),
                const SizedBox(width: 5),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                    style: iconButtonStyle,
                    child: const Icon(
                      Icons.settings_outlined,
                      size: 20,
                      color: Colors.black,
                    )),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Hello, Hari!',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Jost')),
            StatefulBuilder(
              builder: (context, setState) => Consumer<NoteProvider>(
                  // Access provider to call refresh() on add/delete
                  builder: (context, provider, child) =>
                      StreamBuilder<List<Map<String, dynamic>>>(
                        stream: provider.noteStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final notes = snapshot.data!;
                            return Text(
                              'You\'ve made ${notes.length} notes so far!',
                              // ... (existing text style)
                              style: const TextStyle(
                                  fontSize: 20, fontFamily: 'Jost'),
                            );
                          } else {
                            return const Text('Loading...');
                          }
                        },
                      )),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FavoritesPage()));
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Favorites',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Jost',
                              fontSize: 16),
                        ),
                      ],
                    )),
                const SizedBox(width: 8),
                ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage()));
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Search',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Jost',
                              fontSize: 16),
                        ),
                      ],
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
