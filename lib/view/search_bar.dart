import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/themes/theme.dart';
import 'package:notes/core/view_model/note_view_model.dart';
import 'package:notes/view/note_details_view.dart';

class SearchBar extends SearchDelegate {
  NoteViewModel controller = Get.find<NoteViewModel>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear,color: pinkClr,),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
          color: Theme.of(context).iconTheme.color,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? controller.noteList
        : controller.noteList.where((element) {
            return element.title!.toLowerCase().contains(query.toLowerCase()) ||
                element.content!.toLowerCase().contains(query.toLowerCase());
          }).toList();
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        physics:const BouncingScrollPhysics(),

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 15.0,
          childAspectRatio: 1,
        ),
        itemCount: suggestionsList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Get.to(NoteDetailView(), arguments: index);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: customListColor(index),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow:  [
                      BoxShadow(
                          color: customListColor(index),
                          offset:const Offset(3, 3),
                          blurRadius: 10)
                    ]),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      suggestionsList[index].title!,
                      style: textTitleTheme(context),
                      maxLines: 2,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Text(
                        suggestionsList[index].content!,
                        style: textContentTheme(context),
                        maxLines: 6,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      controller.noteList[index].dateTimeEdited!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: textOverLineTheme(context),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
