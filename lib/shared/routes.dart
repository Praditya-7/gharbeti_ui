import 'package:gharbeti_ui/login/screen/login_screen.dart';
import 'package:gharbeti_ui/owner/billing/owner_paid_bills.dart';
import 'package:gharbeti_ui/owner/billing/owner_pending_bills.dart';
import 'package:gharbeti_ui/owner/home/owner_home_screen.dart';
import 'package:gharbeti_ui/owner/home/vacant_room.dart';
import 'package:gharbeti_ui/owner/listings/screens/add_listings_screen.dart';
import 'package:gharbeti_ui/owner/listings/screens/listing_detail.dart';
import 'package:gharbeti_ui/owner/owner_dashboard.dart';
import 'package:gharbeti_ui/owner/tenants/tenant_detail.dart';
import 'package:gharbeti_ui/owner/tenants/tenants_screen.dart';
import 'package:gharbeti_ui/signup/screen/signup_screen.dart';
import 'package:gharbeti_ui/splash_screen/intro_screen.dart';
import 'package:gharbeti_ui/tenant/billing/tenant_paid_bills.dart';
import 'package:gharbeti_ui/tenant/billing/tenant_pending_bills.dart';
import 'package:gharbeti_ui/tenant/discover/discover_listing_detail.dart';
import 'package:gharbeti_ui/tenant/discover/discover_near_you.dart';
import 'package:gharbeti_ui/tenant/tenant_dashboard.dart';
import 'package:gharbeti_ui/tenant/tenant_home_screen.dart';

class Routes {
  static var routes = {
    LoginScreen.route: (ctx) => const LoginScreen(),
    SplashScreen.route: (ctx) => const SplashScreen(),
    SignUpScreen.route: (ctx) => const SignUpScreen(),
    TenantsScreen.route: (ctx) => const TenantsScreen(),
    AddListingsScreen.route: (ctx) => const AddListingsScreen(),
    TenantHomeScreen.route: (ctx) => const TenantHomeScreen(),
    OwnerHomeScreen.route: (ctx) => const OwnerHomeScreen(),
    OwnerDashboardScreen.route: (ctx) => const OwnerDashboardScreen(),
    TenantDashboardScreen.route: (ctx) => const TenantDashboardScreen(),
    VacantRoom.route: (ctx) => const VacantRoom(),
    DiscoverListingDetail.route: (ctx) => const DiscoverListingDetail(),
    ListingDetail.route: (ctx) => const ListingDetail(),
    TenantDetail.route: (ctx) => const TenantDetail(),
    DiscoverNearYou.route: (ctx) => const DiscoverNearYou(),
    OwnerPendingBills.route: (ctx) => const OwnerPendingBills(),
    OwnerPaidBills.route: (ctx) => const OwnerPaidBills(),
    TenantPendingBills.route: (ctx) => const TenantPendingBills(),
    TenantPaidBills.route: (ctx) => const TenantPaidBills(),
  };
}
