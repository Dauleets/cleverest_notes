part of 'edit_bloc.dart';

abstract class EditEvent extends Equatable {
  const EditEvent();

  @override
  List<Object?> get props => [];
}

class SaveNote extends EditEvent {
  final NoteModel note;

  const SaveNote(this.note);

  @override
  List<Object?> get props => [note];
}

class LoadNote extends EditEvent {
  final NoteModel editNote;
  const LoadNote(this.editNote);
  @override
  List<Object?> get props => [editNote];
}
