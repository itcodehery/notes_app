import 'package:flutter/material.dart';
import 'package:notes_app/components/note_card.dart';
import 'package:notes_app/pages/search.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/utils/note_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:notes_app/components/note_appbar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: const String.fromEnvironment('PROJ_URL'),
      anonKey: const String.fromEnvironment('PROJ_KEY'));
  ChangeNotifierProvider(
    create: (context) => NoteProvider(),
    child: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bro Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BroCom Notes'),
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
  final _noteStream =
      Supabase.instance.client.from('notes').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.maxFinite, 120),
            child: NoteAppBar(widget: widget)),
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
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return NoteCard(notes: notes, index: index);
                },
              ),
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
          child: const Icon(Icons.add),
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
    Color selectedColor = const Color.fromARGB(255, 200, 200, 200);

    return Consumer<NoteProvider>(
      builder: (context, mainvalue, child) => SimpleDialog(
        title: const Text('Add a new note'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
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
          // a drop down menu to select the color of the note
          DropdownMenu(
            onSelected: (Color? color) {
              if (color != null) {
                selectedColor = color;
                debugPrint(selectedColor.toString());
              }
            },
            label: const Text('Select a color'),
            menuHeight: 200,
            width: 200,
            dropdownMenuEntries: <DropdownMenuEntry<Color>>[
              for (var color in NoteColors.colors.entries)
                DropdownMenuEntry(
                    value: color.key,
                    label: color.value,
                    leadingIcon: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: color.key,
                          shape: BoxShape.circle,
                        ))),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              debugPrint('Title: $title, Body: $body, Color: $selectedColor');
              final noteProvider = context.read<NoteProvider>();
              await noteProvider.addNote(title, body, selectedColor, context);
            },
            child: const Text('Add Note'),
          ),
        ],
      ),
    );
  }
}
