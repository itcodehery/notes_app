import 'package:flutter/material.dart';
import 'package:notes_app/components/note_appbar.dart';
import 'package:notes_app/components/note_card.dart';
import 'package:notes_app/pages/search.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: '', anonKey: "");
  runApp(ChangeNotifierProvider(
    create: (context) => NoteProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bro Notes',
      home: const MyHomePage(title: 'BroCom Notes'),
      theme: AppTheme.colorTheme,
      routes: {
        '/add': (context) => const MyHomePage(title: 'Add Note'),
        '/search': (context) => SearchPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(230),
            child: NoteTopBar(widget: widget)),
        body: Center(
            child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: value.noteStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final notes = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: MasonryGridView.count(
                  crossAxisCount: 2,
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return NoteCard(notes: notes, index: index);
                  }),
            );
          },
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const NoteDialog();
                });
          },
          tooltip: 'Add a Note',
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black12, width: 1),
          ),
          backgroundColor: AppTheme.colorTheme.primaryColor,
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}

class NoteDialog extends StatefulWidget {
  const NoteDialog({Key? key}) : super(key: key);

  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  @override
  Widget build(BuildContext context) {
    String title = '';
    String body = '';

    return Consumer<NoteProvider>(
      builder: (context, mainvalue, child) => SimpleDialog(
        backgroundColor: AppTheme.colorTheme.disabledColor,
        title: Text(
          'Add a new note',
          style: TextStyle(color: AppTheme.colorTheme.primaryColor),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          TextFormField(
            style: TextStyle(color: AppTheme.colorTheme.primaryColor),
            cursorColor: AppTheme.colorTheme.primaryColor,
            decoration: const InputDecoration(
                labelText: 'Title', fillColor: Colors.white12),
            onChanged: (value) {
              title = value;
              debugPrint(title);
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Body',
            ),
            onChanged: (value) {
              body = value;
              debugPrint(body);
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              debugPrint('Title: $title, Body: $body');
              final noteProvider = context.read<NoteProvider>();
              await noteProvider.addNote(title, body, context);
            },
            child: const Text('Add Note'),
          ),
        ],
      ),
    );
  }
}
