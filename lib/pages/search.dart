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

  Future<void> search(String query) async {
    if (query.isEmpty) {
      return;
    }

    getDatabaseItems(query);
  }

  void getDatabaseItems(String query) async {
    final notesStream =
        await supabase.from('notes').select('*').eq('title', query);
    setState(() {
      searchResults = notesStream;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            autofocus: true,
            onChanged: (value) {
              setState(() {
                debugPrint('entered: $value');
                searchQuery = value;
                search(searchQuery);
              });
            },
            decoration: const InputDecoration(
              hintText: 'Enter search query',
            ),
          ),
        ),
        body: IndexedStack(
          alignment: Alignment.center,
          index: searchResults.isEmpty ? 0 : 1,
          children: [
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index]['title']),
                  subtitle: Text(searchResults[index]['content']),
                );
              },
            ),
          ],
        ));
  }
}
