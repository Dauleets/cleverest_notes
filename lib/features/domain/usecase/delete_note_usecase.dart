import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../../../injection.dart';
import '../repository/note_repository.dart';

class DeleteNoteUsecase extends UseCase<String, int> {
  final NoteRepository repository = sl.get<NoteRepository>();

  DeleteNoteUsecase();

  @override
  Future<Either<Failure, String>> call([int? params]) async {
    try {
      return await repository.deleteNoteById(params!);
    } catch (e) {
      return Left(Failure('Failed delete'));
    }
  }
}
