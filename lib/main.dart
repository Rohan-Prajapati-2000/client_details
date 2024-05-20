import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:practice/utils/theme/theme.dart';
import 'firebase_options.dart';
import 'home_screen/home.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      home: MyHomePage(),
    );
  }
}

