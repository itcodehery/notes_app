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
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            color: notes[index]['color'] != null
                ? Color(int.parse(notes[index]['color']))
                : Theme.of(context).cardColor,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notes[index]['title'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        notes[index]['body'],
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.chevron_right),
              ],
            ),
          )),
    );
  }
}
