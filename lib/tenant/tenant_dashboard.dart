import 'package:flutter/material.dart';
import 'package:gharbeti_ui/chat/screen/chat_screen.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/shared/tenant_dashboard_icons.dart';
import 'package:gharbeti_ui/tenant/billing/tenant_billing_screen.dart';
import 'package:gharbeti_ui/tenant/discover/discover_screen.dart';
import 'package:gharbeti_ui/tenant/home/tenant_home_screen.dart';
import 'package:gharbeti_ui/tenant/notification/notification_screen.dart';
import 'package:gharbeti_ui/tenant/profile/tenant_profile_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TenantDashboardScreen extends StatefulWidget {
  static const route = "/TenantDashboardScreen";

  const TenantDashboardScreen({Key? key}) : super(key: key);

  @override
  _TenantDashboardScreenState createState() => _TenantDashboardScreenState();
}

class _TenantDashboardScreenState extends State<TenantDashboardScreen> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  String getTitle() {
    return _selectedIndex == 0
        ? "Home"
        : _selectedIndex == 1
            ? "Billing"
            : _selectedIndex == 2
                ? "Discover"
                : "Profile";
  }

  onPageChange(index) {
    setState(() {
      _selectedIndex = index;
    });
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
        TenantHomeScreen(),
        BillingTenantScreen(),
        DiscoverTenantScreen(),
        ProfileTenantScreen(),

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
            gTabs("Home", TenantDashboard.home),
            gTabs("Billing", TenantDashboard.wallet),
            gTabs("Discover", Icons.search),
            gTabs("Profile", TenantDashboard.profile),
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
