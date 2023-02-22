import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/core/view_model/auth_view_model.dart';
import 'package:notes/core/view_model/note_view_model.dart';
import 'package:notes/view/sync_data.dart';
import 'package:notes/view/widgets/alert_dialog.dart';
import 'package:notes/view/search_bar.dart';

import '../core/themes/theme.dart';
import '../core/utils/constance.dart';
import 'add_new_note_view.dart';
import 'note_details_view.dart';

class HomeView extends GetWidget<NoteViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Constance.appText(context,"Note"," App"),
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBar());
            },
          ),
          PopupMenuButton(
            onSelected: (val) {
              if (val == 0) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogWidget(
                      contentText: "Are you sure you want to delete all notes?",
                      confirmFunction: () {
                        controller.deleteAllNote();
                        Get.back();
                      },
                      declineFunction: () {
                        Get.back();
                      },
                    );
                  },
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text(
                  "Delete All Notes",
                ),
              )
            ],
          ),
        ],
      ),
      body: GetBuilder<NoteViewModel>(
        builder: (_) =>
            controller.isEmpty() ? _emptyNotes(context) : _viewNotes(),
      ),
      drawer: _drawer(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddNewNoteView());
        },
        child: const Icon(
          Icons.add,
          // color: _.iconTheme.color,
        ),
      ),
    );
  }

  Widget _emptyNotes(BuildContext context) {
    return SingleChildScrollView(
      physics:const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Lottie.asset('assets/note.json'),
          const SizedBox(
            height: 50,
          ),
          Text(
            "You don't have any Notes",
            style: textAppBarTheme(context),
          ),
        ],
      ),
    );
  }

  Widget _viewNotes() {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 15.0,
          childAspectRatio: 1,
        ),
        itemCount: controller.noteList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Get.to(NoteDetailView(), arguments: index);
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogWidget(
                      contentText: "Are you sure you want to delete the note?",
                      confirmFunction: () {
                        controller
                            .deleteNote(controller.noteList[index]);
                        Get.back();
                      },
                      declineFunction: () {
                        Get.back();
                      },
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: customListColor(index),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: customListColor(index).withOpacity(0.5),
                          offset: const Offset(3, 3),
                          blurRadius: 10)
                    ]),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.noteList[index].title!,
                      style: textTitleTheme(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Text(
                        controller.noteList[index].content!,
                        style: textContentTheme(context),
                        maxLines: 6,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      controller.noteList[index].dateTimeEdited!,
                      style: textOverLineTheme(context),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return GetBuilder<NoteViewModel>(builder: (controller) {
      return Drawer(
          child: SafeArea(
        minimum: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 120,
              alignment: AlignmentDirectional.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Text(
                controller.drawerText,
                textAlign: TextAlign.center,
                style: textContentTheme(context).copyWith(
                  color: offWhite,
                ),
              ),
            ),
           const SizedBox(height: 30,),
            Expanded(
              child: Column(
                children:
                [
                  GestureDetector(
                    onTap: () {
                      controller.changeTheme();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Get.isDarkMode ? Icons.sunny : Icons.nightlight),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          Get.isDarkMode ? "Light Mode" : "Dark Mode",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      Get.to(SyncData());
                    },
                    child: Text("sync data screen"),
                  ),

                ],
              ),
            ),
            GetBuilder<AuthViewModel>(
                init: AuthViewModel(),
                builder: (logic) {
                  return GestureDetector(
                    onTap: () {
                      controller.noteList.clear();
                      logic.signOut();
                    },
                    child: const Text(
                      "sign-out",style: TextStyle(color: pinkClr),
                    ),
                  );
                }),
          ],
        ),
      ));
    });
  }
}
