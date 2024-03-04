import 'package:flutter/material.dart';

class NotePreview extends StatelessWidget {
  final String title;
  final String content;
  final DateTime createdOn;

  const NotePreview(
      {super.key,
      required this.title,
      required this.content,
      required this.createdOn});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
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
        Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(
            "${createdOn.day}/${createdOn.month}/${createdOn.year} | ${createdOn.hour}:${createdOn.minute}"),
        const Divider(),
        Text(content)
      ],
    );
  }
}
