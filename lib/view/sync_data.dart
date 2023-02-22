import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/view_model/sync_view_model.dart';

import '../core/themes/theme.dart';
import '../core/themes/theme_services.dart';
import '../core/utils/constance.dart';

class SyncData extends GetWidget<SyncViewModel> {
  const SyncData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _appBar(context),
      body: GetBuilder<SyncViewModel>(
          builder: (logic) {
            return ListView.separated(
              padding: EdgeInsets.all(5),
              physics: BouncingScrollPhysics(),
              itemCount: controller.note.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: customListColor(index),
                    borderRadius: BorderRadius.circular(20),

                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.note[index].title!,
                                style: textTitleTheme(context),
                                overflow: TextOverflow.ellipsis),

                            Text(
                              controller.note[index].content!,
                              style: textContentTheme(context),
                              overflow: TextOverflow.ellipsis, maxLines: 3,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(width: 2,
                          height: double.infinity,
                          child: Container(
                            color: offWhite,

                          ),),
                      ),
                      RotatedBox(quarterTurns: 3,
                        child: Text(controller.note[index].noteId.toString()),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
            );
          }),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Constance.appText(context, "Sync", " Data"),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios),
        color: pinkClr,
      ),
      actions: [
        IconButton(
          onPressed: () {
            ThemeService().switchTheme();
          },
          icon: Icon(Get.isDarkMode ? Icons.nightlight : Icons.sunny),
          color: pinkClr,
        ),
      ],
    );
  }
}
