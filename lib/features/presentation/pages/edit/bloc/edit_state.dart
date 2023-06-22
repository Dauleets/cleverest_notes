// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_bloc.dart';

abstract class EditState extends Equatable {
  const EditState();

  @override
  List<Object?> get props => [];
}

class EditInitial extends EditState {}

class EditLoading extends EditState {}

class EditNoteSaved extends EditState {}

class EditNoteError extends EditState {
  final String errorMessage;

  const EditNoteError(this.errorMessage);
}

class LoadNoteLoading extends EditState {}

class LoadNoteLoaded extends EditState {
  final NoteModel note;
  const LoadNoteLoaded({
    required this.note,
  });
}

class LoadNoteError extends EditState {
  final String errorMessage;

  const LoadNoteError(this.errorMessage);
}
