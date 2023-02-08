import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes/core/themes/theme_services.dart';
import 'package:notes/core/themes/theme.dart';
import 'package:notes/view/home_view.dart';

import 'core/bindings/bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();


  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Note APP",
      debugShowCheckedModeBanner: false,
      theme: ThemesApp.light,
      darkTheme: ThemesApp.dark,
      initialBinding: Binding(),
       themeMode: ThemeService().theme,
      home: HomeView(),
    );
  }
}
