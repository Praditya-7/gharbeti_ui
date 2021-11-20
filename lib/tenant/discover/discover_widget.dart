import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/tenant/discover/service/discover_storage_service.dart';

class DiscoverWidget extends StatelessWidget {
  String wifiAvailable = '';
  String waterAvailable = '';
  String parkingAvailable = '';
  String randomAvailable = '';
  String floor = '';
  String including = '';
  String preferred = '';
  int price = 0;
  String address = '';

  final int index;
  final double width;
  final double height;
  final Room data;
  final Function(int index) onTap;

  DiscoverWidget({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    including = data.kitchen.toString() == 'Yes' ? ' | Room including Kitchen' : ' ';
    print(data.imageName.toString());
    return InkWell(
      onTap: () {
        //onTap Code here
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          children: [
            //Image Here
            FutureBuilder(
              future: DiscoverStorage(listingNo: data.listingNo, email: data.email).downloadURL(
                data.imageName.toString(),
              ),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Container(
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                      height: height * 15,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return Container();
              },
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
                        data.internet == 'Yes' ? 'Available' : 'None',
                        Icons.wifi,
                      ),
                      getRoundedIconWithLabel(
                        data.parking == 'Yes' ? 'Available' : 'None',
                        Icons.local_parking,
                      ),
                      getRoundedIconWithLabel(
                        data.kitchen == 'Yes' ? 'Available' : 'None',
                        Icons.kitchen,
                      ),
                      getRoundedIconWithLabel(
                        data.bathroom == 'Yes' ? 'Available' : 'None',
                        Icons.bathroom,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      //Share function
                    },
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
                  Text(
                    'Rs.' + data.rent.toString() + '/month',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                data.floor.toString() +
                    ' Floor' +
                    ' | ' +
                    data.preferences.toString() +
                    ' Preferred' +
                    including,
                style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
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
