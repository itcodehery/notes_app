import 'package:flutter/material.dart';

class NotePreview extends StatefulWidget {
  final String title;
  final String content;
  final DateTime createdOn;
  final Color bgcolor;

  const NotePreview(
      {super.key,
      required this.title,
      required this.content,
      required this.createdOn,
      required this.bgcolor});

  @override
  State<NotePreview> createState() => _NotePreviewState();
}

class _NotePreviewState extends State<NotePreview> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: widget.bgcolor,
      title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton.filled(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                  maximumSize: MaterialStatePropertyAll(Size(40, 40)),
                  minimumSize: MaterialStatePropertyAll(Size(40, 40)),
                ),
                icon: const Icon(Icons.clear)),
            IconButton.filled(
                onPressed: () {},
                style: const ButtonStyle(
                  maximumSize: MaterialStatePropertyAll(Size(40, 40)),
                  minimumSize: MaterialStatePropertyAll(Size(40, 40)),
                ),
                icon: const Icon(Icons.edit)),
          ]),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.all(20),
      children: [
        Text(widget.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(
            "${widget.createdOn.day}/${widget.createdOn.month}/${widget.createdOn.year} | ${widget.createdOn.hour}:${widget.createdOn.minute}"),
        const Divider(),
        Text(widget.content)
      ],
    );
  }
}
