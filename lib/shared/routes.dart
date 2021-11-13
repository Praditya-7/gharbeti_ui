import 'package:gharbeti_ui/login/screen/login_screen.dart';
import 'package:gharbeti_ui/screens/splash_screen/intro_screen.dart';

class Routes {
  static var routes = {
    LoginScreen.route: (ctx) => const LoginScreen(),
    SplashScreen.route: (ctx) => const SplashScreen(),
  };
}
