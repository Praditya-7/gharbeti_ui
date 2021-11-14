// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/listings/screens/add_listings_screen.dart';
import 'package:gharbeti_ui/shared/color.dart';

class HomeScreenOwner extends StatefulWidget {
  static const route = "/homeScreenOwner";
  const HomeScreenOwner({Key? key}) : super(key: key);

  @override
  State<HomeScreenOwner> createState() => _HomeScreenOwnerState();
}

class _HomeScreenOwnerState extends State<HomeScreenOwner>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int roomCount = 0;
  int vacantCount = 0;
  int occupiedCount = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //ROOM INFO HEADING
            Text(
              "Room Info",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            //ROOM INFO CONTAINER
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 140,
                        height: 135,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffC4D7E4),
                        ),
                        child: Center(
                          child: roomCount == 0
                              ? InkWell(
                                  child: Text(
                                    "Add Room",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddListingsScreen()));
                                  },
                                )
                              : Text(
                                  "$roomCount\nTotal",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      //ROOM INDICATOR
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Vacant Room Indicator
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.0),
                                color: Color(0xff30D472),
                                child: Text(
                                  vacantCount.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Vacant",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          SizedBox(height: 25.0),
                          //occupied Room Indicator
                          Row(
                            children: [
                              //Occupied Indicator
                              Container(
                                padding: EdgeInsets.all(8.0),
                                color: Color(0xffF6821E),
                                child: Text(
                                  occupiedCount.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Occupied",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                child: TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  indicatorColor: Color(ColorData.primaryColor),
                  indicator:
                      BoxDecoration(color: Color(ColorData.primaryColor)),
                  controller: _tabController,
                  tabs: [
                    Tab(
                      text: "Vacant Room",
                    ),
                    Tab(
                      text: "Occupied Room",
                    )
                  ],
                )),
            Container(
              child: TabBarView(
                children: [
                  Text("Tab1", style: TextStyle(color: Colors.black)),
                  Text("Tab2", style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
