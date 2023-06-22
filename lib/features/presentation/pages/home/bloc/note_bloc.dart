import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection.dart';
import '../../../../data/models/note_model.dart';
import '../../../../domain/usecase/delete_note_usecase.dart';
import '../../../../domain/usecase/get_all_notes_usecase.dart';
import '../../../../domain/usecase/reorder_notes_usecase.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetAllNotesUsecase getAllNotesUsecase = sl.get<GetAllNotesUsecase>();
  final DeleteNoteUsecase deleteNoteUsecase = sl.get<DeleteNoteUsecase>();
  final ReorderNotesUsecase reorderNotesUsecase = sl.get<ReorderNotesUsecase>();

  NoteBloc() : super(NoteInitial()) {
    on<LoadNotes>((event, emit) async {
      emit(NoteLoading());
      final loadNotes = await getAllNotesUsecase.call();
      loadNotes.fold((failure) => emit(NoteError(failure.message)),
          (notes) => emit(NoteLoaded(notes)));
    });
    on<DeleteNote>((event, emit) async {
      emit(NoteLoading());
      final loadNotes = await deleteNoteUsecase.call(event.noteId);
      loadNotes.fold(
        (failure) => emit(NoteError(failure.message)),
        (_) => emit(NoteDeleted()),
      );
    });
    on<ReoderNote>((event, emit) async {
      emit(NoteLoading());
      final List<NoteModel> reorderedNotes = List<NoteModel>.from(event.notes);
      final reorderNotes = await reorderNotesUsecase.call(reorderedNotes);
      reorderNotes.fold(
        (failure) => emit(NoteError(failure.message)),
        (_) => emit(ReorderLoaded()),
      );
    });
  }
}
