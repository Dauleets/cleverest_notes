import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../data/models/note_model.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<NoteModel>>> getAllNotes();
  Future<Either<Failure, String>> saveNote(NoteModel note);
  Future<Either<Failure, String>> deleteNoteById(int id);
  Future<Either<Failure, String>> updateNoteById(List<NoteModel> note);
  Future<Either<Failure, NoteModel>> editNoteById(NoteModel editNote);
}
