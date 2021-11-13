// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gharbeti_ui/screens/login/screen/login_screen.dart';
import 'package:gharbeti_ui/screens/splash_screen/intro_screen.dart';
import 'package:gharbeti_ui/shared/routes.dart';
import 'package:gharbeti_ui/switchUser_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      //home: SplashScreen(),
      initialRoute: SplashScreen.route,
      routes: Routes.routes
    );
  }
}
