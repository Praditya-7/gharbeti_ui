// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class HomeScreenOwnerUnregistered extends StatefulWidget {
  static String route = '/homeScreenUnregistered';

  const HomeScreenOwnerUnregistered({Key? key}) : super(key: key);

  @override
  State<HomeScreenOwnerUnregistered> createState() => _HomeScreenOwnerUnregisteredState();
}

class _HomeScreenOwnerUnregisteredState extends State<HomeScreenOwnerUnregistered> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Room Info'),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'No Rooms added',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Recent Payments'),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  child: Text(
                    'Add Tenants to see Payments',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
