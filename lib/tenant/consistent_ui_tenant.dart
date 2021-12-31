// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gharbeti_ui/tenant/profile/tenant_profile_screen.dart';

import 'billing/tenant_billing_screen.dart';
import 'discover/discover_screen.dart';
import 'home/tenant_home_screen.dart';

class ConsistentUITenant extends StatefulWidget {
  const ConsistentUITenant({Key? key}) : super(key: key);

  @override
  _ConsistentUITenantState createState() => _ConsistentUITenantState();
}

class _ConsistentUITenantState extends State<ConsistentUITenant> {
  String title = 'Home';
  int currentIndex = 0;

  final screens = [
    TenantHomeScreen(),
    BillingTenantScreen(),
    DiscoverTenantScreen(),
    ProfileTenantScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: customNavBar(),
    );
  }

  AppBar customAppBar() {
    return title != 'Profile'
        ? AppBar(
            backgroundColor: Color(0xff09548c),
            title: Text(title),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.message),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications),
              ),
            ],
          )
        : AppBar(
            backgroundColor: Color(0xff09548c),
            title: Text(title),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.logout),
              ),
            ],
          );
  }

  BottomNavigationBar customNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedIconTheme: IconThemeData(
        color: Color(0xff09548c),
      ),
      elevation: 50.0,
      selectedLabelStyle: TextStyle(color: Colors.black),
      unselectedLabelStyle: TextStyle(color: Colors.black),
      onTap: (index) {
        setState(() {
          currentIndex = index;
          if (index == 0) {
            title = 'Home';
          } else if (index == 1) {
            title = 'Billing';
          } else if (index == 2) {
            title = 'Discover';
          } else {
            title = 'Profile';
          }
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_balance_wallet,
          ),
          label: 'Billing',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
          ),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_pin,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
