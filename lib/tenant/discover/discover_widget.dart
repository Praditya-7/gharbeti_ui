import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/tenant/discover/service/discover_storage_service.dart';

class DiscoverWidget extends StatefulWidget {
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
  State<DiscoverWidget> createState() => _DiscoverWidgetState();
}

class _DiscoverWidgetState extends State<DiscoverWidget> {
  String including = '';

  Future<String> _getPlace() async {
    String add;
    List<Placemark> newPlace = await placemarkFromCoordinates(
        widget.data.latitude, widget.data.longitude);

    // this is all you need
    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    add = name +
        "," +
        subLocality +
        ",\n" +
        locality +
        "," +
        postalCode +
        ",\n" +
        administrativeArea +
        "," +
        country;
    print(add);
    return add;
  }

  String getAddress() {
    String address = "";
    _getPlace().then((value) {
      address = value;
    });
    return address;
  }

  @override
  Widget build(BuildContext context) {
    including = widget.data.kitchen.toString() == 'Yes'
        ? ' | Room including Kitchen'
        : ' ';

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
              future: DiscoverStorage(
                      listingNo: widget.data.listingNo,
                      email: widget.data.email)
                  .downloadURL(
                widget.data.imageName.toString(),
              ),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                      height: widget.height * 15,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
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
                        widget.data.internet == 'Yes' ? 'Available' : 'None',
                        Icons.wifi,
                      ),
                      getRoundedIconWithLabel(
                        widget.data.parking == 'Yes' ? 'Available' : 'None',
                        Icons.local_parking,
                      ),
                      getRoundedIconWithLabel(
                        widget.data.kitchen == 'Yes' ? 'Available' : 'None',
                        Icons.kitchen,
                      ),
                      getRoundedIconWithLabel(
                        widget.data.bathroom == 'Yes' ? 'Available' : 'None',
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
                            getAddress(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Rs.' + widget.data.rent.toString() + '/month',
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
                widget.data.floor.toString() +
                    ' Floor' +
                    ' | ' +
                    widget.data.preferences.toString() +
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
