import 'package:cleverest_notes/core/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection.dart';
import '../../../../data/models/note_model.dart';
import '../../edit/widgets/edit_wsidgets.dart';
import '../bloc/note_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteModel> notes = [];

  late NoteBloc noteBloc = sl.get<NoteBloc>();

  @override
  void initState() {
    super.initState();
    noteBloc = BlocProvider.of<NoteBloc>(context, listen: false);
    noteBloc.add(LoadNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 120,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Text(
              'TODO LIST',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 35),
            child: IconButton(
              onPressed: () => context.go('/editnote'),
              icon: SvgPicture.asset(
                'assets/icons/plus.svg',
                fit: BoxFit.cover,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<NoteBloc, NoteState>(
          listener: (context, state) {
            if (state is NoteLoaded) {
              notes = state.notes;
            } else if (state is NoteDeleted) {
              setState(() {
                noteBloc.add(LoadNotes());
              });
            }
          },
          builder: (context, state) {
            if (state is NoteLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (notes.isEmpty) {
              return const Center(child: Text('No notes'));
            }
            return ReorderableListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 40,
              ),
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                setState(() {
                  final NoteModel note = notes.removeAt(oldIndex);
                  notes.insert(newIndex, note);
                  noteBloc.add(ReoderNote(notes));
                });
              },
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Dismissible(
                  key: Key('${note.id}_$index'),
                  background: const DeleteContainer(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    setState(() {
                      notes.removeAt(index);
                    });

                    if (note.id != null) {
                      if (kDebugMode) {
                        print('Deleting note with ID: ${note.id}');
                      }
                      noteBloc.add(DeleteNote(note.id! - 1));
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadowColor,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => context.go('/editnote', extra: note),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          note.title ?? '',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      subtitle: Text(
                        note.text ?? '',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
