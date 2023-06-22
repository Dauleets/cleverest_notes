import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/note_model.dart';
import '../pages/edit/pages/note_edit_page.dart';
import '../pages/home/pages/home_page.dart';

class AppRoutes {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        routes: [
          GoRoute(
            path: 'editnote',
            pageBuilder: (context, state) {
              NoteModel? sample = state.extra as NoteModel?;
              return CustomTransitionPage(
                key: state.pageKey,
                child: NoteEditPage(noteModel: sample),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
              );
            },
          )
        ],
      ),
    ],
  );
}
