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
  // dummy initialization
  // initialize won't work without actual url and key
  await Supabase.initialize(
      url: 'https://<supabase-url>.supabase.co', anonKey: 'public-anon-key');
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
            preferredSize: const Size.fromHeight(250),
            child: NoteTopBar(widget: widget)),
        body: Center(
            child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: value.noteStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final notes = snapshot.data!;

            if (notes.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // image from assets
                  // const Image(
                  //   image: AssetImage('assets/images/nonotes.png'),
                  //   width: 200,
                  //   height: 200,
                  // ),
                  Text(
                    'No notes yet',
                    style: TextStyle(
                      color: AppTheme.colorTheme.splashColor,
                      fontFamily: 'Jost',
                      fontSize: 20,
                    ),
                  ),
                ],
              ));
            }
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
    //function return
    return SimpleDialog(
      backgroundColor: AppTheme.colorTheme.disabledColor,
      title: Text(
        'Add a new note',
        style: TextStyle(
            color: AppTheme.colorTheme.primaryColor, fontFamily: 'Jost'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        TextFormField(
          style: const TextStyle(color: Colors.white),
          cursorColor: AppTheme.colorTheme.primaryColor,
          decoration: getInputDeco('Title'),
          onChanged: (value) {
            title = value;
            debugPrint(title);
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: getInputDeco('Body'),
          onChanged: (value) {
            body = value;
            debugPrint(body);
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                minimumSize: const MaterialStatePropertyAll(Size(100, 50)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Jost', fontSize: 16)),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppTheme.colorTheme.primaryColor),
                minimumSize: const MaterialStatePropertyAll(Size(120, 50)),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.black38, width: 4)),
                ),
              ),
              onPressed: () async {
                debugPrint('Title: $title, Body: $body');
                final noteProvider = context.read<NoteProvider>();
                await noteProvider.addNote(title, body, context);
              },
              child: const Text('Add Note',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Jost', fontSize: 16)),
            ),
          ],
        ),
      ],
    );
  }

  InputDecoration getInputDeco(String labelText) {
    return InputDecoration(
        filled: true,
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                color: AppTheme.colorTheme.primaryColorDark, width: 2)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide:
                BorderSide(color: Color.fromARGB(57, 193, 255, 58), width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide:
                BorderSide(color: AppTheme.colorTheme.primaryColor, width: 2)),
        labelStyle: TextStyle(color: AppTheme.colorTheme.primaryColor),
        labelText: labelText,
        fillColor: Colors.white12);
  }
}
