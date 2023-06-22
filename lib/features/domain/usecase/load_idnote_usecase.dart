import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../../data/models/note_model.dart';
import '../../../injection.dart';
import '../repository/note_repository.dart';

class LoadIdNoteUsecase extends UseCase<NoteModel, NoteModel> {
  final NoteRepository repository = sl.get<NoteRepository>();

  LoadIdNoteUsecase();

  @override
  Future<Either<Failure, NoteModel>> call([NoteModel? params]) async {
    try {
      return await repository.editNoteById(params!);
    } catch (e) {
      return Left(Failure('Failure get notes'));
    }
  }
}
