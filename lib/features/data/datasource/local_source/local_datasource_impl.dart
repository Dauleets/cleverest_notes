import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cleverest_notes/core/error/failures.dart';
import 'package:cleverest_notes/features/data/datasource/local_source/local_datasource.dart';
import 'package:cleverest_notes/features/data/models/note_model.dart';

class LocalDataSourceImpl implements LocalDataSource {
  static const String noteBoxName = 'notes_db';

  Future<Box<NoteModel>> openNoteBox() async {
    if (!Hive.isBoxOpen(noteBoxName)) {
      await Hive.openBox<NoteModel>(noteBoxName);
    }
    return Hive.box<NoteModel>(noteBoxName);
  }

  LocalDataSourceImpl();

  @override
  Future<List<NoteModel>> getAllNotes() async {
    try {
      final box = await openNoteBox();
      final notes = box.values.toList();
      final sortedNotes = List<NoteModel>.from(notes);

      sortedNotes.sort((a, b) => a.createdDate!.compareTo(b.createdDate!));

      return sortedNotes;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<String> saveNote(NoteModel note) async {
    try {
      final box = await openNoteBox();
      final lastNote = box.values.toList().lastOrNull;
      final id = lastNote?.id! != null ? lastNote!.id! + 1 : 0;

      if (kDebugMode) {
        print(id);
      }
      await box.add(note.copyWith(id: id));
      return 'ok';
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<String> deleteNoteById(int id) async {
    try {
      final box = await openNoteBox();
      await box.delete(box.getAt(id)!.key);
      box.close();
      return 'ok';
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<String> reorderNotes(List<NoteModel> notes) async {
    try {
      final box = await openNoteBox();
      for (var i = 0; i < notes.length; i++) {
        final note = notes[i];
        note.order = i;
        note.createdDate = DateTime.now();
        await box.put(note.key, note);
      }
      box.close();
      return 'ok';
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<NoteModel> editNoteById(NoteModel editNote) async {
    try {
      final box = await openNoteBox();

      if (box.containsKey(editNote.key)) {
        final note = box.get(editNote.key);
        if (note != null) {
          note.text = editNote.text;
          note.title = editNote.text!.split('\n').first;
          await box.put(editNote.key, note);
          box.close();
          return note;
        } else {
          throw Failure('Note with key ${editNote.key} does not exist.');
        }
      } else {
        throw Failure('Note with key ${editNote.key} does not exist.');
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
