import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:cleverest_notes/core/theme/colors.dart';
import 'package:cleverest_notes/features/data/models/note_model.dart';

import '../../home/bloc/note_bloc.dart';
import '../bloc/edit_bloc.dart';
import '../widgets/edit_wsidgets.dart';

class NoteEditPage extends StatefulWidget {
  final NoteModel? noteModel;
  const NoteEditPage({
    this.noteModel,
    Key? key,
  }) : super(key: key);

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final EditBloc editBloc = EditBloc();
  late TextEditingController _textController;
  bool contr1 = false;
  bool ismptyModel = false;

  bool isFirstLineEntered = false;
  @override
  void initState() {
    _textController = TextEditingController();
    _textController.addListener(() {
      setState(() {
        isFirstLineEntered = _textController.text.isNotEmpty &&
            _textController.text.contains('\n');
        contr1 = _textController.text.isNotEmpty;
      });
    });

    if (widget.noteModel != null) {
      _textController.text = widget.noteModel!.text ?? '';
      ismptyModel = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM d, HH:mm').format(now);

    return BlocConsumer<EditBloc, EditState>(
      listener: (context, state) {
        if (state is EditNoteSaved) {
          BlocProvider.of<NoteBloc>(context).add(LoadNotes());
        } else if (state is LoadNoteLoaded) {
          BlocProvider.of<NoteBloc>(context).add(LoadNotes());
          context.pop(true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.colorGreen,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 100,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, size: 30),
              onPressed: () => context.pop(true),
            ),
            titleSpacing: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EDIT/ADD TASK',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              primary: true,
              child: Center(
                  child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 45),
                height: 330,
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          'What are you planning?',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: AppColors.colorLigthGreen),
                        ),
                        TextFormField(
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.colorBlack,
                                    fontWeight: isFirstLineEntered
                                        ? FontWeight.w400
                                        : FontWeight.w600,
                                  ),
                          decoration: InputDecoration(
                            hintText: '>Type here...',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: AppColors.colorBlack.withOpacity(0.6),
                                ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          controller: _textController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 9,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.colorGreen,
                              width: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/alarm.svg',
                              fit: BoxFit.cover,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              formattedDate,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )),
            ),
          ),
          floatingActionButton: ismptyModel
              ? CustomFloatingActionButton(
                  active: ismptyModel,
                  onPressed: ismptyModel
                      ? () {
                          editBloc.add(LoadNote(NoteModel(
                            createdDate: now,
                            text: _textController.text,
                            title: _textController.text.split('\n').first,
                          )));
                          BlocProvider.of<NoteBloc>(context).add(LoadNotes());
                          context.pop(true);
                        }
                      : null,
                )
              : CustomFloatingActionButton(
                  active: contr1,
                  onPressed: contr1
                      ? () {
                          editBloc.add(
                            SaveNote(
                              NoteModel(
                                createdDate: now,
                                text: _textController.text,
                                title: _textController.text.split('\n').first,
                              ),
                            ),
                          );
                          BlocProvider.of<NoteBloc>(context).add(LoadNotes());
                          context.pop(true);
                        }
                      : null,
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    // editBloc.close();
    super.dispose();
  }
}
