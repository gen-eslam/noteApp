import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/view_model/note_view_model.dart';

import '../core/themes/theme.dart';

class AddNewNoteView extends GetWidget<NoteViewModel> {

 const AddNewNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "Add New Note",
          style: textContentTheme(context),
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.clearAddNote();
            },
            icon: const Icon(Icons.delete_forever, color: pinkClr),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              TextField(
                controller: controller.titleController,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: textHintTheme(context, 27),
                  border: InputBorder.none,
                ),
              ),
              TextField(
                style: const TextStyle(
                  fontSize: 22,
                ),
                controller: controller.contentController,
                decoration: InputDecoration(
                  hintText: "Content",
                  hintStyle: textHintTheme(context, 23)
                      .copyWith(fontWeight: FontWeight.w600),
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
          controller.addNoteToDatabase();
        },
        child: const Icon(
          Icons.check,
        ),
      ),
    );
  }
}
