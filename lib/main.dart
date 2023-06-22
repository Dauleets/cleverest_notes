import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cleverest_notes/features/presentation/pages/edit/bloc/edit_bloc.dart';
import 'package:cleverest_notes/features/presentation/router/app_routes.dart';

import 'core/theme/theme.dart';
import 'features/presentation/pages/home/bloc/note_bloc.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<NoteBloc>()),
        BlocProvider(create: (context) => di.sl<EditBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Cleverest Notes',
        theme: Styles.themeData(context),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes().router,
      ),
    );
  }
}
