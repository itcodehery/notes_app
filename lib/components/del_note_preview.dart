import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/theme.dart';
import 'package:provider/provider.dart';

class DeletedNotePreview extends StatefulWidget {
  final String title;
  final String content;
  final DateTime createdOn;
  final Color bgcolor;
  final int id;

  const DeletedNotePreview(
      {super.key,
      required this.title,
      required this.content,
      required this.createdOn,
      required this.bgcolor,
      required this.id});

  @override
  State<DeletedNotePreview> createState() => _DeletedNotePreviewState();
}

class _DeletedNotePreviewState extends State<DeletedNotePreview> {
  @override
  Widget build(BuildContext context) {
    // variables
    var buttonStyle = ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll(Colors.white),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
      ),
      padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
      fixedSize: const MaterialStatePropertyAll(Size(60, 60)),
    );
    var textStyle = TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: AppTheme.colorTheme.primaryColor,
        fontFamily: 'Jost');
    const textStyle2 =
        TextStyle(fontSize: 18, color: Colors.white70, fontFamily: 'Jost');

    // function return
    return Consumer<NoteProvider>(
      builder: (context, value, child) => SimpleDialog(
        backgroundColor: AppTheme.colorTheme.canvasColor,
        title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              // delete forever
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppTheme.colorTheme.canvasColor,
                  title: Text('Delete forever?', style: textStyle),
                  content: const Text(
                    'Are you sure you want to delete this note forever?',
                    style: textStyle2,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No',
                          style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                      ),
                      onPressed: () async {
                        await value.deleteNote(widget.id).then((value) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      },
                      child: const Text(
                        'Yes',
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'Jost'),
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              );
            },
            child: const Icon(
              Icons.delete_forever_outlined,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () async {
              await value
                  .setAsNotDeleted(widget.id)
                  .then((value) => Navigator.pop(context));
            },
            child: const Icon(
              Icons.restore,
              color: Colors.black,
            ),
          ),
        ]),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.bottomCenter,
        insetPadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.all(20),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.white12, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: textStyle),
                    const SizedBox(height: 10),
                    Text(
                      "${widget.createdOn.day}/${widget.createdOn.month}/${widget.createdOn.year} | ${widget.createdOn.hour}:${widget.createdOn.minute}",
                      style: textStyle2,
                    ),
                  ]),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(widget.content, style: textStyle2),
          )
        ],
      ),
    );
  }
}
