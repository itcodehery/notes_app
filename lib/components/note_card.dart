import 'package:flutter/material.dart';
import 'package:notes_app/components/note_preview.dart';
import 'package:notes_app/theme.dart';

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
                bgcolor: notes[index]['color'] ?? Theme.of(context).cardColor,
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
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(
            color: Colors.white12,
            width: 1,
          ),
        ),
        elevation: 0,
        color: notes[index]['color'] ?? AppTheme.colorTheme.cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                SizedBox(
                    width: 90,
                    child: Text(
                      notes[index]['title'] ?? 'Untitled',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.colorTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )),
                const Spacer(),
                Icon(
                  Icons.arrow_outward_sharp,
                  color: AppTheme.colorTheme.primaryColor,
                ),
              ]),
              const SizedBox(height: 4),
              Text(
                notes[index]['body'] ?? 'No content',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.colorTheme.splashColor,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
