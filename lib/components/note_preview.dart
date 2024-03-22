import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/theme.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  IconData favoriteIcon = Icons.circle_outlined;

  Future<bool> getIsFavorite(int id) async {
    var boolema = false;
    boolema = await Supabase.instance.client
        .from('notes')
        .select()
        .eq('id', id)
        .then((value) => value[0]['is_favorite'] as bool);
    debugPrint('$boolema');
    return boolema;
  }

  @override
  void initState() {
    super.initState();
    getIsFavorite(widget.id).then((value) {
      if (value) {
        setState(() {
          favoriteIcon = Icons.favorite;
        });
      } else {
        setState(() {
          favoriteIcon = Icons.favorite_border;
        });
      }
    });
  }

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
            onPressed: () async {
              if (await getIsFavorite(widget.id)) {
                debugPrint('Entered if');
                await value.setAsNotFavorite(widget.id);
                setState(() {
                  favoriteIcon = Icons.favorite_border;
                });
              } else {
                debugPrint('Entered else');
                await value.setAsFavorite(widget.id);
                setState(() {
                  favoriteIcon = Icons.favorite;
                });
              }
            },
            child: Icon(
              favoriteIcon,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () async {
              await value.setAsDeleted(widget.id).then((value) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Note deleted',
                        style: TextStyle(fontSize: 18, fontFamily: 'Jost')),
                    duration: Duration(seconds: 2),
                  ),
                );
              });
              //toast
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
