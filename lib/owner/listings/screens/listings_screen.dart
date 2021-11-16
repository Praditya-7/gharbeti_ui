// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';

import 'add_listings_screen.dart';
import 'listing_detail.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({Key? key}) : super(key: key);

  @override
  _ListingsScreenState createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  String listingType = 'ROOM';
  String listingNumber = '1';
  String listingStatus = 'Occupied';
  String floor = "First";

  List<String> entries = <String>[
    '1',
    '2',
    '3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddListingsScreen.route);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff09548c),
      ),
      body: SafeArea(
        child: ListView.separated(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: entries.length,
          separatorBuilder: (BuildContext context, int index) => Divider(
            height: 0.1,
            indent: 0,
            thickness: 0.1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListingDetail(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.all(12),
                height: 150,
                color: Colors.white,
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: ColorData.primaryColor,
                      ),
                      child: Image(
                        image: AssetImage("assets/image/logo_image.png"),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BuildText(
                          text: listingType + ' NO ' + entries[index],
                          weight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        BuildText(
                          text: "Floor : " + floor,
                          weight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                        //Status
                        Row(
                          children: [
                            Text(
                              'Status : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: listingStatus == 'Vacant'
                                    ? Color(0xff30d472)
                                    : Colors.orange,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    listingStatus,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
