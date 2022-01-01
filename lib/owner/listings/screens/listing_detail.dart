// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/owner/home/vacant_room.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class ListingDetail extends StatefulWidget {
  static String route = '/listingDetail';
  const ListingDetail({Key? key}) : super(key: key);

  @override
  _ListingDetailState createState() => _ListingDetailState();
}

class _ListingDetailState extends State<ListingDetail> {
  Room args = Room(latitude: 0, longitude: 0);
  User userData = User();
  String name = 'Ram Shrestha';
  int tid = 1001;
  int roomNo = 420;
  String floor = "First";
  int bathroom = 1;
  int kitchen = 1;
  String date = "2021/01/01";
  int rent = 9000;
  int electricityCharge = 1000;
  int lastMeterReading = 230;
  int waterCharge = 500;
  int internetCharge = 1500;
  double height = 0.0;
  double width = 0.0;

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as Room;

    super.didChangeDependencies();
  }

  setData() async {
    final pref = await SharedPreferences.getInstance();
    var tenantEmail = pref.getString("TenantEmail");
    var query = _fireStore
        .collection('Users')
        .where("Email", isEqualTo: tenantEmail)
        .get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          userData = User.fromFireStoreSnapshot(doc);
        }
      }
    });
    print(userData.name);

    setState(() {
      //abc
    });
    pref.setString("TenantEmail", "");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text("Listing Detail"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(8.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.meeting_room_sharp,
                            size: 60,
                            color: Colors.black,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Room No " + args.listingNo.toString(),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "Status : ",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: args.status.toString() == "Vacant"
                                      ? Color(0xff30d472)
                                      : Colors.orange,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    args.status.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Room Info",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18.0),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onTap: () {
                              deleteData();
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Floor : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " " + args.floor.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Bathroom : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " " + args.bathroom.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Kitchen : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " " + args.kitchen.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),

                          //ADD START DATE WHEN ADDING TENANT

                          RichText(
                            text: TextSpan(
                              text: "Start Date : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " " + date.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Last Meter Reading : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text:
                                        " " + args.lastMeterReading.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Rent : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " Rs." + args.rent.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              args.status == "Vacant"
                  ? Container(
                margin: EdgeInsets.all(10),
                      height: height * 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(VacantRoom.route, arguments: args);
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                          child: Center(
                            child: Text(
                              'Add Tenant',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              //Occupied By
              args.tenantEmail == ""
                  ? Container()
                  : Container(
                      margin: EdgeInsets.fromLTRB(10.0, 5.0, 0, 0),
                      child: Text(
                        "Occupied By",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black),
                      )),
              args.tenantEmail == ""
                  ? Container()
                  : Container(
                      margin: EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Center(
                        child: ListTile(
                          leading: Container(
                            width: 75,
                            height: 200,
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
                          title: Text(userData.name.toString(),
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            args.tenantEmail.toString(),
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  deleteData() async {
    final pref = await SharedPreferences.getInstance();
    var ownerEmail = pref.getString("email");
    var query = _fireStore
        .collection('Rooms')
        .where("ListingNo", isEqualTo: args.listingNo.toString())
        .where("OwnerEmail", isEqualTo: ownerEmail)
        .get();
    await query.then((value) async {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          await doc.reference.delete().then((value) {
            Navigator.pop(context, true);
          });
        }
      }
    });
  }
}
