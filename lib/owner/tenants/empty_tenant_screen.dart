// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'add_tenants_screen.dart';

class TenantsScreen extends StatefulWidget {
  static String route = '/tenantScreen';
  const TenantsScreen({Key? key}) : super(key: key);

  @override
  _TenantsScreenState createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff09548c),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTenantsScreen()),
          );
        },
      ),
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.all(12),
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text("No Tenants Available"),
            )),
      ),
    );
  }
}
