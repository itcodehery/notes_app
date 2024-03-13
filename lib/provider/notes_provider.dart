import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteProvider extends ChangeNotifier {
  final _noteStream = Supabase.instance.client
      .from('notes')
      .stream(primaryKey: ['id']).eq('is_deleted', false);
  final _deletednoteStream = Supabase.instance.client
      .from('notes')
      .stream(primaryKey: ['id']).eq('is_deleted', true);

  Stream<List<Map<String, dynamic>>> get noteStream => _noteStream;
  Stream<List<Map<String, dynamic>>> get deletedNoteStream =>
      _deletednoteStream;

  void refresh() {
    notifyListeners();
  }

  Future<void> addNote(String title, String body, BuildContext context) async {
    await Supabase.instance.client.from('notes').insert({
      'title': title,
      'body': body,
    }).then((value) => Navigator.pop(context));
    refresh();
  }

  Future<void> deleteNote(int id) async {
    await Supabase.instance.client.from('notes').delete().eq('id', id);
    refresh();
  }

  Future<void> setAsDeleted(int id) async {
    await Supabase.instance.client
        .from('notes')
        .update({'is_deleted': true}).eq('id', id);
    refresh();
  }

  Future<void> setAsNotDeleted(int id) async {
    await Supabase.instance.client
        .from('notes')
        .update({'is_deleted': false}).eq('id', id);
    refresh();
  }

  Future<void> setAsFavorite(int id) async {
    await Supabase.instance.client
        .from('notes')
        .update({'is_favorite': true}).eq('id', id);
    refresh();
  }

  Future<void> setAsNotFavorite(int id) async {
    await Supabase.instance.client
        .from('notes')
        .update({'is_favorite': false}).eq('id', id);
    refresh();
  }
}
