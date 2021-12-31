// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:gharbeti_ui/tenant/discover/discover_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TenantHomeScreen extends StatefulWidget {
  static String route = '/homeScreenRegistered';

  const TenantHomeScreen({Key? key}) : super(key: key);

  @override
  _TenantHomeScreenState createState() => _TenantHomeScreenState();
}

class _TenantHomeScreenState extends State<TenantHomeScreen> {
  String tenantStatus = "unregistered";
  int dueBalance = 8000;
  String status = 'Paid';
  late String balance = dueBalance.toString();
  final pref = SharedPreferences.getInstance();
  String roomName = "";

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    final pref = await SharedPreferences.getInstance();
    roomName = pref.getString("roomName").toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      // appBar: ReusableWidgets.getAppBar(title),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: roomName == ""
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _getNoLeaseWidget("No active lease"),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BuildText(
                                text: "Looking for New Home?",
                                fontSize: 16,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              BuildText(
                                text:
                                    "If you want to rent a new home, start looking from thousands of listings and apply online using yourRenter Profile.",
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: ColorData.primaryColor,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DiscoverTenantScreen()));
                                },
                                child: Text("find New"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(10, 15.0, 10, 10),
                      padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Balance Due'),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Rs. ' + balance + '.00',
                            style: TextStyle(
                              color: Color(0xff09548c),
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Status: '),
                              Text(
                                status,
                                style: TextStyle(
                                  color: status == 'Paid' ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              primary: Colors.white, // <-- Button color
                            ),
                            child: Container(
                              height: 35,
                              color: Colors.deepOrangeAccent,
                              child: Center(
                                child: Text(
                                  'Pay Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(10, 0.0, 10, 15),
                      padding: EdgeInsets.fromLTRB(0, 15.0, 0, 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.message,
                                      color: Color(0xff09548c),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      side: BorderSide(
                                        width: 1.5,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      padding: EdgeInsets.all(18),
                                      primary: Colors.white, // <-- Button color
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text('Send Message'),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.home_repair_service_outlined,
                                      color: Color(0xff09548c),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      side: BorderSide(
                                        width: 1.5,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      padding: EdgeInsets.all(18),
                                      primary: Colors.white, // <-- Button color
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text('Add Request'),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.note_alt,
                                      color: Color(0xff09548c),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      side: BorderSide(
                                        width: 1.5,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      padding: EdgeInsets.all(18),
                                      primary: Colors.white, // <-- Button color
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text('Pending Bills'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _getNoLeaseWidget(String title) {
    return Expanded(
      child: Container(
        height: 199,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildText(
                text: title,
                fontSize: 16,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                  "Your landlord needs to connect with you in the system and share the lease with you",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  )),
            ],
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
