import 'package:flutter/material.dart';
import 'package:notes_app/components/note_card.dart';
import 'package:notes_app/pages/search.dart';
import 'package:notes_app/utils/note_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:notes_app/components/note_appbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: const String.fromEnvironment('PROJ_URL'),
    anonKey: const String.fromEnvironment('PROJ_KEY'),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.maxFinite, 120),
          child: NoteAppBar(widget: widget)),
      body: Center(
          child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _noteStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final notes = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
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
              builder: ((context) {
                return const NoteDialog();
              }));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
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
    Color selectedColor = Colors.white;

    return SimpleDialog(
      title: const Text('Add a new note'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Title',
          ),
          onChanged: (value) => title = value,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Body',
          ),
          onChanged: (value) => body = value,
        ),
        // a row or similar widget to select the colors for the note
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: NoteColors.colors.map((e) {
              return InkWell(
                onTap: () {
                  // set the color of the note
                  setState(() {
                    selectedColor = e;
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.only(right: 2),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: e),
                  child: selectedColor == e
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 10,
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await Supabase.instance.client.from('notes').insert({
              'title': title,
              'body': body,
              'color': selectedColor.toString()
            }).then((value) => Navigator.pop(context));
          },
          child: const Text('Add Note'),
        ),
      ],
    );
  }
}
