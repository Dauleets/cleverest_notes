import 'package:cleverest_notes/features/data/datasource/local_source/local_datasource_impl.dart';
import 'package:cleverest_notes/features/presentation/pages/edit/bloc/edit_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/data/datasource/local_source/local_datasource.dart';
import 'features/data/models/note_model.dart';
import 'features/domain/repository/note_repository.dart';
import 'features/domain/usecase/delete_note_usecase.dart';
import 'features/domain/usecase/get_all_notes_usecase.dart';
import 'features/domain/usecase/load_idnote_usecase.dart';
import 'features/domain/usecase/reorder_notes_usecase.dart';
import 'features/domain/usecase/save_note_usecase.dart';
import 'features/presentation/pages/home/bloc/note_bloc.dart';
import 'features/data/repository/note_repository_impl.dart';
import 'package:path_provider/path_provider.dart' as path;

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => EditBloc());
  sl.registerFactory(() => NoteBloc());

  // Repository
  sl.registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl());

  // Use case
  sl.registerLazySingleton(() => GetAllNotesUsecase());
  sl.registerLazySingleton(() => DeleteNoteUsecase());
  sl.registerLazySingleton(() => SaveNoteUsecase());
  sl.registerLazySingleton(() => ReorderNotesUsecase());
  sl.registerLazySingleton(() => LoadIdNoteUsecase());

  // Data sources
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  //Hive DateBase
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.initFlutter('notes_db');
  Hive.registerAdapter(NoteModelAdapter());
}
