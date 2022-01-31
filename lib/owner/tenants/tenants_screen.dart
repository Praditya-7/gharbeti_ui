// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';
import 'package:gharbeti_ui/owner/tenants/tenant_widget.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class TenantsScreen extends StatefulWidget {
  static String route = '/tenantScreen';
  const TenantsScreen({Key? key}) : super(key: key);

  @override
  _TenantsScreenState createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  List<User> tenantList = [];
  bool isLoading = true;
  int tenantCount = 0;
  List<Room> roomList = [];
  List<Room> tenantRoomList = [];
  double width = 0.0;
  double height = 0.0;

  String tenantName = 'Ram Shrestha';
  String listingType = 'Flat';
  List<int> dueRemaining = [
    15000,
    0,
    1600,
  ];

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    roomList.clear();
    final pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    var query1 = _fireStore
        .collection('Rooms')
        .where("OwnerEmail", isEqualTo: email)
        .get();
    await query1.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          roomList.add(Room.fromFireStoreSnapshot(doc));
        }
      }
    });

    if (roomList.isNotEmpty) {
      for (int i = 0; i < roomList.length; i++) {
        var query2 = _fireStore
            .collection('Users')
            .where("Email", isEqualTo: roomList[i].tenantEmail)
            .get();
        await query2.then((value) {
          if (value.docs.isNotEmpty) {
            for (var doc in value.docs) {
              tenantList.add(User.fromFireStoreSnapshot(doc));
              tenantRoomList.add(roomList[i]);
            }
          }
        });
      }
    }

    setState(() {
      tenantCount = tenantList.length;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: tenantCount == 0
                  ? Container(
                      margin: EdgeInsets.all(12),
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          "No Tenants Available",
                        ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: tenantCount,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        height: 0.1,
                        indent: 0,
                        thickness: 0.1,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return TenantScreenWidget(
                          index: index,
                          width: width,
                          height: height,
                          tenantData: tenantList[index],
                          roomData: tenantRoomList[index],
                          onTap: (index) {},
                        );
                      },
                    ),
            ),
            Visibility(
              visible: isLoading,
              child: CustomProgressIndicatorWidget(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
