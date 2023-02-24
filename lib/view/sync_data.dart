import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/view_model/sync_view_model.dart';
import 'package:notes/view/widgets/custom_button.dart';

import '../core/themes/theme.dart';
import '../core/themes/theme_services.dart';
import '../core/utils/constance.dart';

class SyncData extends GetWidget<SyncViewModel> {
  const SyncData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      appBar: _appBar(context),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
          CustomButton(text: "sync data", onPressed: () {controller.syncData();}),
      ],
    ),);
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
