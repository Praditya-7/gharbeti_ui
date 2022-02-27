// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:gharbeti_ui/tenant/discover/discover_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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
  String ownerEmail = '';
  List<User> userDataList = [];
  User tenantDoc = User();
  User ownerDoc = User();
  Room tenantRoom = Room(longitude: 0, latitude: 0);
  List<Room> roomOwnerDataList = [];
  double width = 0.0;
  double height = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    final pref = await SharedPreferences.getInstance();

    var email = pref.getString("email");
    var roomNo = pref.getString("roomName");

    var query1 =
        _fireStore.collection('Users').where("Email", isEqualTo: email).get();
    await query1.then((value) async {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          userDataList.add(User.fromFireStoreSnapshot(doc));
        }
      }
    }).catchError((e) {
      print(e);
    });

    var query2 = _fireStore
        .collection('Rooms')
        .where("ListingNo", isEqualTo: roomNo)
        .get();
    await query2.then(
      (value) async {
        if (value.docs.isNotEmpty) {
          for (var doc in value.docs) {
            tenantRoom = Room.fromFireStoreSnapshot(doc);
          }
        }
      },
    ).catchError((e) {
      print(e);
    });

    var query3 = _fireStore
        .collection('Users')
        .where("Email", isEqualTo: tenantRoom.ownerEmail)
        .get();
    await query3.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          ownerDoc = User.fromFireStoreSnapshot(doc);
        }
      }
    });

    setState(
      () {
        roomName = pref.getString("roomName").toString();
        tenantDoc = userDataList.first;
        isLoading = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Stack(
          children: [
            Visibility(
              visible: isLoading,
              child: CustomProgressIndicatorWidget(),
            ),
            SingleChildScrollView(
              child: Container(
                //margin: EdgeInsets.all(10.0),
                child: roomName == ""
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _getNoLeaseWidget("No active lease"),
                          SizedBox(height: 10.0),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(10.0),
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
                                      weight: FontWeight.normal,
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
                                                builder: (context) =>
                                                    DiscoverTenantScreen()));
                                      },
                                      child: Text("Find New"),
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
                            color: ColorData.primaryColor,
                            width: double.infinity,
                            height: 75,
                            padding: EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BuildText(
                                    text:
                                        "Welcome, ${tenantDoc.name.toString()}",
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                  Image.asset('assets/image/logo_image.png'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(8.0),
                                color: ColorData.primaryColor,
                                width: double.infinity,
                                padding: EdgeInsets.all(10.0),
                                child: BuildText(
                                  text: "Payment Overview",
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                margin: EdgeInsets.fromLTRB(10, 15.0, 10, 0),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Status: '),
                                        Text(
                                          status,
                                          style: TextStyle(
                                            color: status == 'Paid'
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors
                                            .deepOrangeAccent, // <-- Button color
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
                            ],
                          ),
                          SizedBox(height: 50.0),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(8.0),
                                color: ColorData.primaryColor,
                                width: double.infinity,
                                padding: EdgeInsets.all(10.0),
                                child: BuildText(
                                  text: "Lease Owner",
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                  ),
                                  margin: const EdgeInsets.fromLTRB(
                                      10.0, 5, 10.0, 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: width * 20,
                                        height: height * 10,
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://googleflutter.com/sample_image.jpg',
                                            ),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${ownerDoc.name.toString()}\n${ownerDoc.phoneNumber.toString()}",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff09548C),
                                    ),
                                    icon: Icon(
                                      Icons.call,
                                      color: Colors.white,
                                    ),
                                    label: Text('Call Now'),
                                    onPressed: () {
                                      launch(
                                          "tel:${ownerDoc.phoneNumber.toString()}");
                                    },
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff09548C),
                                    ),
                                    icon: Icon(
                                      Icons.message,
                                      color: Colors.white,
                                    ),
                                    label: Text('Message'),
                                    onPressed: () {
                                      launch(
                                          "sms:${ownerDoc.phoneNumber.toString()}");
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getNoLeaseWidget(String title) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10.0),
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
