import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/color.dart';

class OccupiedRoom extends StatefulWidget {
  const OccupiedRoom({Key? key}) : super(key: key);

  @override
  _OccupiedRoomState createState() => _OccupiedRoomState();
}

class _OccupiedRoomState extends State<OccupiedRoom> {
  String listingType = 'Flat';
  String listingNumber = '1';
  String listingStatus = 'Occupied';

  List<String> entries = <String>[
    '1',
    '2',
    '3',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: Color(ColorData.primaryColor),
        title: Text("Occupied Listing"),
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
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                margin: EdgeInsets.all(12),
                height: 150,
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 150,
                          child: Image(
                            image: NetworkImage(
                                "https://cdn.pixabay.com/photo/2016/11/18/17/20/living-room-1835923__480.jpg"),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listingType + ' No ' + entries[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.pin_drop,
                                      color: Color(ColorData.primaryColor),
                                    ),
                                  ),
                                  TextSpan(
                                    text: " Lainchaur,Kathmandu",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.orange),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 8, 30, 8),
                                child: Center(
                                  child: Text(
                                    'Occupied',
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
                    Divider(
                      thickness: 3.0,
                    ),
                    Text("SINGLE-FAMILY / PARKING / ELECTRICITY ")
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
