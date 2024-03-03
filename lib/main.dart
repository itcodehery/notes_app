import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  void addNewNote() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _noteStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final notes = snapshot.data!;

          return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteCard(notes: notes, index: index);
              });
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: ((context) {
                String title = '';
                String body = '';
                return SimpleDialog(
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
                      onChanged: (value) => title = value,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Body',
                      ),
                      onChanged: (value) => body = value,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await Supabase.instance.client
                            .from('notes')
                            .insert({'title': title, 'body': body}).then(
                                (value) => Navigator.pop(context));
                      },
                      child: const Text('Add Note'),
                    ),
                  ],
                );
              }));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.notes,
    required this.index,
  });

  final List<Map<String, dynamic>> notes;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: const Icon(Icons.chevron_right),
      title: Text(notes[index]['title'],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: Text(notes[index]['body']),
    );
  }
}
