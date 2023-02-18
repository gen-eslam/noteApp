import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes/core/view_model/note_view_model.dart';
import 'package:notes/view/edit_note_view.dart';
import 'package:notes/view/home_view.dart';
import 'package:notes/view/widgets/alert_dialog.dart';

import '../core/themes/theme.dart';

class NoteDetailView extends StatelessWidget {
  final NoteViewModel controller = Get.find();


  NoteDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final int i = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              // color: Theme.of(context
              // ).iconTheme.color,
            ),
            onPressed: () {
              Get.to(
                EditNoteView(),
                arguments: i,
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              Get.bottomSheet(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialogWidget(
                                contentText:
                                    "Are you sure you want to delete the note?",
                                confirmFunction: () {
                                  controller.deleteNote(
                                      controller.noteList[i]);
                                  Get.offAll(const HomeView());
                                },
                                declineFunction: () {
                                  Get.back();
                                },
                              );
                            },
                          );
                        },
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.delete,
                              color: pinkClr,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: 20,
                                color: pinkClr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextButton(
                        onPressed: () {
                          controller.shareNote(
                            controller.noteList[i].title!,
                            controller.noteList[i].content!,
                          );
                        },
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.share,
                              color: bluishClr,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Share",
                              style: TextStyle(
                                fontSize: 20,
                                color: bluishClr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Created :  ${controller.noteList[i].dateTimeCreated!}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Content Word Count :  ${controller.contentWordCount.toString()}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Content Character Count :  ${controller.contentCharCount.toString()}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 150,
                          ),
                          const Text(
                            ///todo change gen to user
                            "Created by Gen",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                backgroundColor: Theme.of(context).backgroundColor,
              );
            },
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: GetBuilder<NoteViewModel>(
        builder: (_) => Scrollbar(
          child: Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    controller.noteList[i].title!,
                    style:textTitleTheme(context).copyWith(
                      fontSize: 25,
                    )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Last Edited : ${controller.noteList[i].dateTimeEdited}",
                    style:textOverLineTheme(context).copyWith(
                      fontSize: 12,
                    )
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  SelectableText(
                    controller.noteList[i].content!,
                    toolbarOptions:const ToolbarOptions(copy: true,cut: true,selectAll: true,),
                    style: textContentTheme(context).copyWith(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
