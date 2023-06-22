import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../../data/models/note_model.dart';
import '../../../injection.dart';
import '../repository/note_repository.dart';

class SaveNoteUsecase extends UseCase<String, NoteModel> {
  final NoteRepository repository = sl.get<NoteRepository>();

  SaveNoteUsecase();

  @override
  Future<Either<Failure, String>> call([NoteModel? params]) async {
    try {
      return await repository.saveNote(params!);
    } catch (e) {
      return Left(Failure('Failure saved'));
    }
  }
}
