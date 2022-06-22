// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:vandad_flutter_course/services/crud/crud.dart';
import 'package:vandad_flutter_course/utils/utils.dart';

typedef DeleteNoteCallBack = void Function(DataBaseNote note);

class NotesListViewComponent extends StatelessWidget {
  final List<DataBaseNote> notes;
  final DeleteNoteCallBack onDeleteNote;

  const NotesListViewComponent({
    Key? key,
    required this.notes,
    required this.onDeleteNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            notes[index].text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeleteNote(notes[index]);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
