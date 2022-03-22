// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';
import 'package:gharbeti_ui/owner/tenants/document_widget.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:url_launcher/url_launcher.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class TenantDetail extends StatefulWidget {
  static String route = '/tenantDetail';
  const TenantDetail({Key? key}) : super(key: key);

  @override
  _TenantDetailState createState() => _TenantDetailState();
}

class _TenantDetailState extends State<TenantDetail> {
  User args = User();

  late String name = 'Ram Shrestha';
  late String address = 'Kathmandu';
  late String email = 'shrestharam@gmail.com';

  late int contact = 988634269;
  late int emContact = 988634269;
  late String listType = 'Room';
  late int listingNo = 402;
  late int tid = 1001;
  String paymentStatus = 'pending';

  double width = 0.0;
  double height = 0.0;
  bool isLoading = true;
  User userDoc = User();
  Room roomDoc = Room(longitude: 0, latitude: 0);

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as User;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 20.0,
          ),
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
              //CALL FUNCTION
              launch("tel:${args.phoneNumber}");
            },
          ),
          SizedBox(
            width: 10.0,
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
              //MESSAGE FUNCTION HERE
              launch("sms:${args.phoneNumber}");
            },
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text("Tenant Details"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              color: Colors.white,
              child: Column(
                children: [
                  Center(
                    child: ListTile(
                      leading: Container(
                        width: 75,
                        height: 200,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/image/avatar.png'),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      title: Text(
                        args.name.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        args.email.toString(),
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Details",
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
                            //DELETE FUNCTION
                            delete();
                          },
                        ),
                      ],
                    ),
                  ),
                  //Address
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Gender(Add to Sign Up Form)
                        RichText(
                          text: TextSpan(
                            text: "Gender : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " " + args.gender.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      color: Color(0xff494949)))
                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        //Contact
                        RichText(
                          text: TextSpan(
                            text: "Contact : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " " + args.phoneNumber.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      color: Color(0xff494949)))
                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        //Listing type
                        RichText(
                          text: TextSpan(
                            text: "Listing Type : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " " + listType,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      color: Color(0xff494949)))
                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        //Listing No
                        RichText(
                          text: TextSpan(
                            text: "Listing No : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " " + args.roomName.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      color: Color(0xff494949)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8.0),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorData.primaryColor,
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: const BuildText(
                        text: "Document",
                        color: Colors.white,
                      ),
                    ),
                    SingleChildScrollView(
                      child: args.pdfLink == ""
                          ? const Text('No Document Found')
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: 1,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(
                                height: 0.1,
                                indent: 0,
                                thickness: 0.1,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return DocumentWidget(
                                  height: height,
                                  width: width,
                                  data: args,
                                  onTap: (index) {
                                    //ROUTE CODE HERE
                                  },
                                );
                              },
                            ),
                    ),
                    //Pending Bills

                    SizedBox(height: 25.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> delete() async {
    var query1 = _fireStore
        .collection('Rooms')
        .where("ListingNo", isEqualTo: args.roomName.toString())
        .get();
    await query1.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          roomDoc = Room.fromFireStoreSnapshot(doc);
        }
      }
    }).catchError(
      (error) => print("Failed to get DocumentID: $error"),
    );
    await _fireStore.collection('Rooms').doc(roomDoc.documentId).update({
      "Tenant Email": "",
      "Status": "Vacant",
    }).then((value) async {
      print("REMOVED TO USERS");
      var query2 = _fireStore
          .collection('Users')
          .where("Email", isEqualTo: args.email.toString())
          .get();
      await query2.then((value) {
        if (value.docs.isNotEmpty) {
          for (var doc in value.docs) {
            userDoc = User.fromFireStoreSnapshot(doc);
          }
        }
      }).catchError(
        (error) => print("Failed to get DocumentID: $error"),
      );
      await _fireStore.collection('Users').doc(userDoc.documentId).update({
        "Room Name": "",
      }).then((value) {
        print("REMOVED TO USERS");
        Navigator.pop(context);
      }).catchError(
        (error) => print("Failed to UPDATE: $error"),
      );
    }).catchError(
      (error) => print("Failed to UPDATE: $error"),
    );
  }
}
