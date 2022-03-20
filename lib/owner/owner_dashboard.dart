import 'package:flutter/material.dart';
import 'package:gharbeti_ui/chat/screen/chat_screen.dart';
import 'package:gharbeti_ui/notification/notification_screen.dart';
import 'package:gharbeti_ui/owner/billing/owner_billing_screen.dart';
import 'package:gharbeti_ui/owner/listings/screens/listings_screen.dart';
import 'package:gharbeti_ui/owner/profile/owner_profile_screen.dart';
import 'package:gharbeti_ui/owner/tenants/tenants_screen.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/owner_dashboard_icons.dart';
import 'package:gharbeti_ui/shared/push_notification_controller.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'home/owner_home_screen.dart';

class OwnerDashboardScreen extends StatefulWidget {
  static const route = "/ownerDashboardScreen";

  const OwnerDashboardScreen({Key? key}) : super(key: key);

  @override
  _OwnerDashboardScreenState createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  String getTitle() {
    return _selectedIndex == 0
        ? "Home"
        : _selectedIndex == 1
            ? "Tenants"
            : _selectedIndex == 2
                ? "Listing"
                : _selectedIndex == 3
                    ? "Billing"
                    : "Profile";
  }

  onPageChange(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    FirebaseNotification().initilizeNotification(context);
    WidgetsBinding.instance!.addObserver(this);
    FirebaseNotification().firebaseNavigate(context);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if ((state == AppLifecycleState.resumed)) {
      FirebaseNotification().firebaseNavigate(context);
    }
  }

  onTabChange(index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final width = SizeConfig.safeBlockHorizontal;
    final height = SizeConfig.safeBlockVertical;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTitle(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorData.primaryColor,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ChatScreen.routeName);
            },
            icon: const Icon(
              Icons.message,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NotificationScreen.route);
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _dashBody(height!, width!),
      bottomNavigationBar: _btmNavBar(height, width),
    );
  }

  Widget _dashBody(double height, double width) {
    return PageView(
      controller: pageController,
      onPageChanged: (value) => onPageChange(value),
      children: const [
        OwnerHomeScreen(),
        TenantsScreen(),
        ListingsScreen(),
        BillingScreenOwner(),
        ProfileScreenOwner(),
        // userType == "Team Lead" ? TeamLeadScreen() : Profile(),
        // LeaveScreen(),
        // Attendance(),
        // MoreScreen(),
      ],
    );
  }

  Widget _btmNavBar(double height, double width) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: GNav(
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 100),
          tabs: [
            gTabs("Home", OwnerDashboard.home),
            gTabs("Tenants", OwnerDashboard.tenant),
            gTabs("Listing", OwnerDashboard.listing),
            gTabs("Billing", OwnerDashboard.wallet),
            gTabs("Profile", OwnerDashboard.profile),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) => onTabChange(index),
        ));
  }
}

GButton gTabs(String text, IconData icon) {
  var padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  return GButton(
    gap: 10,
    icon: icon,
    iconColor: Colors.black,
    iconActiveColor: const Color(0xFF4E7CFD),
    text: text,
    textColor: const Color(0xFF4E7CFD),
    backgroundColor: const Color(0xFF4E7CFD).withOpacity(0.2),
    iconSize: 20,
    padding: padding,
  );
}
