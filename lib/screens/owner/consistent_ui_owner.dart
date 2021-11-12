// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gharbeti_ui/screens/owner/billing/billing_screen.dart';
import 'package:gharbeti_ui/screens/owner/home/home_screen.dart';
import 'package:gharbeti_ui/screens/owner/listings/listings_screen.dart';
import 'package:gharbeti_ui/screens/owner/profile/profile_screen.dart';


import 'tenants/tenants_screen.dart';

class ConsistentUIOwner extends StatefulWidget {
  const ConsistentUIOwner({Key? key}) : super(key: key);

  @override
  _ConsistentUIOwnerState createState() => _ConsistentUIOwnerState();
}

class _ConsistentUIOwnerState extends State<ConsistentUIOwner> {
  String title = 'Home';
  int currentIndex = 0;

  final screens = [
    HomeScreenOwner(),
    TenantsScreen(),
    ListingsScreen(),
    BillingScreenOwner(),
    ProfileScreenOwner(),
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
            title = 'Tenants';
          } else if (index == 2) {
            title = 'Listings';
          } else if (index == 3) {
            title = 'Billing';
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
            label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people_alt,
          ),
          label: 'Tenants',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.meeting_room_sharp,
          ),
          label: 'Listings',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_balance_wallet,
          ),
          label: 'Billing',
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
