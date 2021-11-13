import 'package:gharbeti_ui/login/screen/login_screen.dart';
import 'package:gharbeti_ui/owner/tenants/tenants_screen.dart';
import 'package:gharbeti_ui/signup/screen/signup_screen.dart';
import 'package:gharbeti_ui/splash_screen/intro_screen.dart';
import 'package:gharbeti_ui/tenant/home_screen_registered.dart';

class Routes {
  static var routes = {
    LoginScreen.route: (ctx) => const LoginScreen(),
    SplashScreen.route: (ctx) => const SplashScreen(),
    SignUpScreen.route: (ctx) => const SignUpScreen(),
    TenantsScreen.route: (ctx) => const TenantsScreen(),
    HomeScreenRegistered.route: (ctx) => const HomeScreenRegistered(),
  };
}
