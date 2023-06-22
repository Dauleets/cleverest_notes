import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../../data/models/note_model.dart';
import '../../../injection.dart';
import '../repository/note_repository.dart';

class ReorderNotesUsecase extends UseCase<String, List<NoteModel>> {
  final NoteRepository repository = sl.get<NoteRepository>();

  ReorderNotesUsecase();

  @override
  Future<Either<Failure, String>> call([List<NoteModel>? params]) async {
    try {
      return await repository.updateNoteById(params!);
    } catch (e) {
      throw Failure('Failed to update note order.');
    }
  }
}
