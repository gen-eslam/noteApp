import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/view_model/note_view_model.dart';

import '../core/themes/theme.dart';


class EditNoteView extends GetWidget<NoteViewModel> {

  const EditNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final int i = ModalRoute.of(context)!.settings.arguments as int;
    controller.titleController.text = controller.noteList[i].title!;
    controller.contentController.text = controller.noteList[i].content!;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme:Theme.of(context).iconTheme,
        title: Text(
          "Edit Note",
          style: textAppBarTheme(context),
        ),
      ),
      body: SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child: Container(
          padding:const EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              TextField(
                controller: controller.titleController,
                style:textTitleTheme(context),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: textHintTheme(context,27),
                  border: InputBorder.none,
                ),
              ),
              TextField(
                style:textContentTheme(context),
                controller: controller.contentController,
                decoration: InputDecoration(
                  hintText: "Content",
                  hintStyle: textHintTheme(context, 17),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.updateNote(
              controller.noteList[i].noteId!, controller.noteList[i].dateTimeCreated!);
        },
        child:const Icon(Icons.save),
      ),
    );
  }
}