import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteProvider extends ChangeNotifier {
  final _noteStream =
      Supabase.instance.client.from('notes').stream(primaryKey: ['id']);

  Stream<List<Map<String, dynamic>>> get noteStream => _noteStream;

  void refresh() {
    notifyListeners();
  }

  Future<void> addNote(String title, String body, Color selectedColor,
      BuildContext context) async {
    await Supabase.instance.client.from('notes').insert({
      'title': title,
      'body': body,
      'colors': selectedColor.toString()
    }).then((value) => Navigator.pop(context));
    notifyListeners();
  }
}
