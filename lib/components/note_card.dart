import 'package:flutter/material.dart';
import 'package:notes_app/components/note_preview.dart';

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
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return NotePreview(
                bgcolor: notes[index]['color'] != null
                    ? Color(int.parse(notes[index]['color']))
                    : Theme.of(context).cardColor,
                title: notes[index]['title'],
                content: notes[index]['body'],
                createdOn: DateTime.parse(
                  notes[index]['created_at'],
                ),
              );
            });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 1,
        color: notes[index]['color'] != null
            ? Color(int.parse(notes[index]['color']))
            : Theme.of(context).cardColor,
        child: ListTile(
          trailing: const Icon(Icons.chevron_right),
          title: Text(notes[index]['title'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle: Text(notes[index]['body'],
              maxLines: 6, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
