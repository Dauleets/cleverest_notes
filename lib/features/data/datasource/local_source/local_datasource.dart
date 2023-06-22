import 'package:cleverest_notes/features/data/models/note_model.dart';

abstract class LocalDataSource {
  Future<List<NoteModel>> getAllNotes();
  Future<String> saveNote(NoteModel note);
  Future<String> deleteNoteById(int id);
  Future<String> reorderNotes(List<NoteModel> note);
  Future<NoteModel> editNoteById(NoteModel editNote);
}
