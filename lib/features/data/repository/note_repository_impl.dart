import 'package:cleverest_notes/features/data/datasource/local_source/local_datasource.dart';
import 'package:cleverest_notes/features/data/models/note_model.dart';
import 'package:cleverest_notes/features/domain/repository/note_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../injection.dart';

class NoteRepositoryImpl implements NoteRepository {
  final LocalDataSource localDataSource = sl.get<LocalDataSource>();

  NoteRepositoryImpl();

  @override
  Future<Either<Failure, List<NoteModel>>> getAllNotes() async {
    try {
      final notes = await localDataSource.getAllNotes();
      return Right(notes);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveNote(NoteModel note) async {
    try {
      final okMessage = await localDataSource.saveNote(note);
      return Right(okMessage);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteNoteById(int id) async {
    try {
      final okMessage = await localDataSource.deleteNoteById(id);
      return Right(okMessage);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateNoteById(List<NoteModel> note) async {
    try {
      final okMessage = await localDataSource.reorderNotes(note);
      return Right(okMessage);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NoteModel>> editNoteById(NoteModel editNote) async {
    try {
      final okMessage = await localDataSource.editNoteById(editNote);
      return Right(okMessage);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
