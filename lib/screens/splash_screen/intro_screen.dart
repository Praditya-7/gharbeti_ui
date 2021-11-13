import 'package:flutter/material.dart';
import 'package:gharbeti_ui/login/screen/login_screen.dart';
import 'package:gharbeti_ui/shared/color.dart';

class SplashScreen extends StatefulWidget {
  static String route = '/splashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      // if (pref.getBool("login") != null && pref.getBool("login")!)
      //   Navigator.of(context).pushReplacementNamed(HomepageScreen.route);
      // else
        Navigator.of(context).pushReplacementNamed(LoginScreen.route);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(ColorData.primaryColor),
        child: Center(
          child: Image.asset("assets/image/logo_image.png"),
        ),
      ),
    );
  }
}
