import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/components/del_note_card.dart';
import 'package:notes_app/components/note_card.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/theme.dart';
import 'package:provider/provider.dart';

class DeletedNotesPage extends StatefulWidget {
  const DeletedNotesPage({Key? key}) : super(key: key);

  @override
  State<DeletedNotesPage> createState() => _DeletedNotesPageState();
}

class _DeletedNotesPageState extends State<DeletedNotesPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Spacer(),
              Text('Deleted Notes',
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
        body: Center(
            child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: value.deletedNoteStream,
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
                    return DeletedNoteCard(notes: notes.toList(), index: index);
                  }),
            );
          },
        )),
      ),
    );
  }
}
