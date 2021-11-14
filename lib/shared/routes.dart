import 'package:gharbeti_ui/login/screen/login_screen.dart';
import 'package:gharbeti_ui/owner/home/owner_home_screen.dart';
import 'package:gharbeti_ui/owner/listings/screens/add_listings_screen.dart';
import 'package:gharbeti_ui/owner/owner_dashboard.dart';
import 'package:gharbeti_ui/owner/tenants/tenants_screen.dart';
import 'package:gharbeti_ui/signup/screen/signup_screen.dart';
import 'package:gharbeti_ui/splash_screen/intro_screen.dart';
import 'package:gharbeti_ui/tenant/home_screen_registered.dart';
import 'package:gharbeti_ui/tenant/tenant_dashboard.dart';

class Routes {
  static var routes = {
    LoginScreen.route: (ctx) => const LoginScreen(),
    SplashScreen.route: (ctx) => const SplashScreen(),
    SignUpScreen.route: (ctx) => const SignUpScreen(),
    TenantsScreen.route: (ctx) => const TenantsScreen(),
    AddListingsScreen.route: (ctx) => const AddListingsScreen(),
    TenantHomeScreenRegistered.route: (ctx) =>
        const TenantHomeScreenRegistered(),
    OwnerHomeScreen.route: (ctx) => const OwnerHomeScreen(),
    OwnerDashboardScreen.route: (ctx) => const OwnerDashboardScreen(),
    TenantDashboardScreen.route: (ctx) => const TenantDashboardScreen(),
  };
}
