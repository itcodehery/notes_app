import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/theme.dart';
import 'package:provider/provider.dart';

class NotePreview extends StatefulWidget {
  final String title;
  final String content;
  final DateTime createdOn;
  final Color bgcolor;
  final int id;

  const NotePreview(
      {super.key,
      required this.title,
      required this.content,
      required this.createdOn,
      required this.bgcolor,
      required this.id});

  @override
  State<NotePreview> createState() => _NotePreviewState();
}

class _NotePreviewState extends State<NotePreview> {
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
    return SimpleDialog(
      backgroundColor: AppTheme.colorTheme.canvasColor,
      title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    backgroundColor: AppTheme.colorTheme.disabledColor,
                    elevation: 2,
                    title: Text(
                      'Are you sure you want to delete this note?',
                      style: TextStyle(
                        color: AppTheme.colorTheme.primaryColor,
                        fontFamily: 'Jost',
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
                              minimumSize:
                                  const MaterialStatePropertyAll(Size(100, 50)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Jost',
                                    fontSize: 16)),
                          ),
                          const Spacer(),
                          Consumer<NoteProvider>(
                            builder: (context, value, child) {
                              return ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppTheme.colorTheme.primaryColor),
                                  minimumSize: const MaterialStatePropertyAll(
                                      Size(120, 50)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  await value.deleteNote(widget.id);
                                },
                                child: const Text('Delete',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Jost',
                                        fontSize: 16)),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                });
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.delete_outline,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.edit_outlined,
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
    );
  }
}
