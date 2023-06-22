part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotes extends NoteEvent {}

class DeleteNote extends NoteEvent {
  final int noteId;

  const DeleteNote(this.noteId);

  @override
  List<Object?> get props => [noteId];
}

class ReoderNote extends NoteEvent {
  final List<NoteModel> notes;

  const ReoderNote(this.notes);

  @override
  List<Object?> get props => [notes];
}
