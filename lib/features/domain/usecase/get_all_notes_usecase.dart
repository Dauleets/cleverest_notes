import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../../data/models/note_model.dart';
import '../../../injection.dart';
import '../repository/note_repository.dart';

class GetAllNotesUsecase extends UseCase<List<NoteModel>, NoParams> {
  final NoteRepository repository = sl.get<NoteRepository>();

  GetAllNotesUsecase();

  @override
  Future<Either<Failure, List<NoteModel>>> call([NoParams? params]) async {
    try {
      return await repository.getAllNotes();
    } catch (e) {
      return Left(Failure('Failure get notes'));
    }
  }
}
