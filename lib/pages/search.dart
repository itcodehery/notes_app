import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/components/note_card.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

// Initialize Supabase client
final supabase = SupabaseClient('YOUR_SUPABASE_URL', 'YOUR_SUPABASE_KEY');

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = '';
  List<Map<String, dynamic>> searchResults = [];

  List<Map<String, dynamic>> search(
      List<Map<String, dynamic>> listToSearch, String searchQuery) {
    List<Map<String, dynamic>> results = [];
    for (var note in listToSearch) {
      if (note['title'].toString().contains(searchQuery) ||
          note['content'].toString().contains(searchQuery)) {
        results.add(note);
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 237, 255, 207),
            title: TextFormField(
              autofocus: true,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    searchQuery = '';
                  } else {
                    debugPrint('entered: $value');
                    searchQuery = value;
                  }
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter search query',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.none),
                ),
              ),
            ),
            foregroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: StreamBuilder(
              stream: value.noteStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final notes = snapshot.data!;
                searchResults = search(notes, searchQuery);
                if (searchResults.isEmpty) {
                  return const Center(
                      child: Text(
                    'No results found',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jost',
                      color: Colors.white,
                    ),
                  ));
                }
                return ListView.builder(
                    itemCount: searchResults.length,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    itemBuilder: (context, index) {
                      return NoteCard(notes: searchResults, index: index);
                    });
              })),
    );
  }
}
