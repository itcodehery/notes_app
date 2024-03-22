import 'package:flutter/material.dart';
import 'package:notes_app/components/note_preview.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/theme.dart';
import 'package:provider/provider.dart';

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
    return Consumer<NoteProvider>(
      builder: (context, value, child) => InkWell(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) {
                return NotePreview(
                  id: notes[index]['id'],
                  bgcolor: notes[index]['color'] ?? Theme.of(context).cardColor,
                  title: notes[index]['title'],
                  content: notes[index]['body'],
                  createdOn: DateTime.parse(
                    notes[index]['created_at'],
                  ),
                );
              });
        },
        onDoubleTap: () {},
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return NotePreview(
                  id: notes[index]['id'],
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
          color: AppTheme.colorTheme.cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  SizedBox(
                      width: 100,
                      child: Text(
                        notes[index]['title'] ?? 'Untitled',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppTheme.colorTheme.primaryColor,
                          fontFamily: 'Jost',
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )),
                  const Spacer(),
                  Icon(
                    Icons.arrow_outward_sharp,
                    size: 16,
                    color: AppTheme.colorTheme.primaryColor,
                  ),
                ]),
                const SizedBox(height: 4),
                Text(
                  notes[index]['body'] ?? 'No content',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Jost',
                    color: AppTheme.colorTheme.splashColor,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                // if (notes[index]['tags'] != null)
                //   Container(
                //     height: 30,
                //     alignment: Alignment.centerLeft,
                //     padding: const EdgeInsets.symmetric(horizontal: 20),
                //     decoration: BoxDecoration(
                //       color: AppTheme.colorTheme.canvasColor,
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: Text(
                //       notes[index]['tags'],
                //       style: TextStyle(
                //           color: AppTheme.colorTheme.primaryColor,
                //           fontFamily: 'Jost',
                //           fontSize: 16),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
