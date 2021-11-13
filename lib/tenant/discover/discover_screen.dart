// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'discover_listing_detail.dart';


class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _destinationController = TextEditingController();
  final List<String> entries = <String>[
    'Baishak',
    'Jestha',
    'Ashar',
    'Shrawan',
    'Bhadra',
    'Ashwin',
  ];
  String wifiAvailable = 'Available';
  String waterAvailable = 'Available';
  String parkingAvailable = 'None';
  String randomAvailable = 'Available';

  String floor = 'Ground';
  String included = 'Kitchen';
  String preferred = 'Family';

  int price = 9000;
  String address = 'Shakti Bhakti Marga, Gongabu, Kathmandu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 20),
          padding: EdgeInsets.only(left: 5, right: 20),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(0xffEEEEEE),
          ),
          child: TextField(
            controller: _destinationController,
            cursorColor: Color(0xff09548c),
            decoration: InputDecoration(
              focusColor: Color(0xff09548c),
              fillColor: Color.fromRGBO(240, 240, 240, 1),
              filled: true,
              icon: Icon(
                Icons.search,
                color: Color(0xff09548c),
              ),
              hintText: "Search Destination",
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.location_on_outlined,
              color: Color(0xff09548c),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.slider_horizontal_3,
              color: Color(0xff09548c),
            ),
          ),
        ],
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
            return Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiscoverListingDetail(),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.grey,
                      height: 125,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            getRoundedIconWithLabel(
                              wifiAvailable,
                              Icons.wifi,
                            ),
                            getRoundedIconWithLabel(
                              waterAvailable,
                              CupertinoIcons.sparkles,
                            ),
                            getRoundedIconWithLabel(
                              parkingAvailable,
                              Icons.local_parking,
                            ),
                            getRoundedIconWithLabel(
                              randomAvailable,
                              Icons.night_shelter,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            color: Color(0xff09548c),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color(0xff09548c),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: SizedBox(
                                width: 200,
                                child: Text(
                                  address,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text('Rs.' + price.toString() + '/month'),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      floor +
                          ' Floor' +
                          ' | Room including ' +
                          included +
                          ' | ' +
                          preferred +
                          ' Preferred',
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getRoundedIconWithLabel(String available, IconData iconData) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color(0xff09548c),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              iconData,
              size: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            available,
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
