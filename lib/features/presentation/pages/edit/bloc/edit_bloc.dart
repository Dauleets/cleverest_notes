import 'package:equatable/equatable.dart';

import 'package:cleverest_notes/features/data/models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection.dart';
import '../../../../domain/usecase/load_idnote_usecase.dart';
import '../../../../domain/usecase/save_note_usecase.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final SaveNoteUsecase saveNoteUsecase = sl.get<SaveNoteUsecase>();
  final LoadIdNoteUsecase loadIdNoteUsecase = sl.get<LoadIdNoteUsecase>();

  EditBloc() : super(EditInitial()) {
    on<SaveNote>((event, emit) async {
      emit(EditLoading());
      final loadNotes = await saveNoteUsecase.call(event.note);
      loadNotes.fold((failure) => emit(EditNoteError(failure.message)),
          (ok) => emit(EditNoteSaved()));
    });

    on<LoadNote>((event, emit) async {
      emit(LoadNoteLoading());
      final loadNotes = await loadIdNoteUsecase.call(event.editNote);
      loadNotes.fold((failure) => emit(LoadNoteError(failure.message)),
          (note) => emit(LoadNoteLoaded(note: note)));
    });
  }
}
