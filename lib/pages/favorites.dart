import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/note_preview.dart';
import 'package:notes_app/theme.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/provider/notes_provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Spacer(),
            Text('Favorite Notes',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Jost',
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color.fromARGB(255, 237, 255, 207),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: Consumer<NoteProvider>(builder: (context, value, child) {
        StreamBuilder(
          stream: value.favoriteNoteStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CupertinoActivityIndicator(
                color: AppTheme.colorTheme.primaryColor,
              );
            }
            final notes = snapshot.data!;
            if (notes.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NotePreview(
                  title: notes[index]['title'],
                  content: notes[index]['content'],
                  createdOn: DateTime.parse(notes[index]['created_on']),
                  bgcolor: Color(int.parse(notes[index]['bgcolor'])),
                  id: notes[index]['id'],
                );
              },
            );
          },
        );
      }),
    );
  }
}
