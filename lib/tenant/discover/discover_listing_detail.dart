// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'carousel.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class DiscoverListingDetail extends StatefulWidget {
  static String route = '/discoverListingDetail';
  const DiscoverListingDetail({Key? key}) : super(key: key);

  @override
  _DiscoverListingDetailState createState() => _DiscoverListingDetailState();
}

class _DiscoverListingDetailState extends State<DiscoverListingDetail> {
  Room args = Room(latitude: 0, longitude: 0);
  late GoogleMapController _googleMapController;

  double width = 0.0;
  double height = 0.0;
  int price = 9000;
  String address = "Shakti Bhakti Marga, Gongabu, Kathmandu";
  String floor = "First";
  String name = "Ram Shrestha";
  String preference = "Family";
  int bathroomNo = 1;
  String intOption = "Available";
  String parkingOption = "Available";
  String addDescription = "This is additional Description";

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as Room;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text("Listing Detail"),
      ),
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
              launch("tel:9803374994");
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
              launch("sms:9803374994");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselWithIndicator(
                  imgList: args.imagesLinkList,
                ),
                SizedBox(height: 5.0),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
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
                                args.address.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                softWrap: false,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Rs.' + args.rent.toString() + '/month',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //OwnerName
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //TO BE IMPLEMENTED
                          const Text(
                            "Owner Email",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(args.ownerEmail.toString()),
                        ],
                      ),
                      //Preferences
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Preferences",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text(args.preferences.toString()),
                        ],
                      ),
                      //Floor
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Floor",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text(args.floor.toString()),
                        ],
                      )
                    ],
                  ),
                ),

                //Basic Amenities
                Container(
                  margin: EdgeInsets.only(top: 10),
                  color: ColorData.primaryColor,
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  child: BuildText(
                    text: "Basic Amenities",
                    color: Colors.white,
                  ),
                ),

                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //bathRooms No
                      RichText(
                        text: TextSpan(
                          text: "BathRooms : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: " " + args.bathroom.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                    color: Color(0xff494949)))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      //Kitchen
                      RichText(
                        text: TextSpan(
                          text: "Kitchen : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: " " + args.kitchen.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                    color: Color(0xff494949)))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      // Internet
                      RichText(
                        text: TextSpan(
                          text: "Internet : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: " " + args.internet.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                    color: Color(0xff494949)))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      //parking
                      RichText(
                        text: TextSpan(
                          text: "Parking : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: " " + args.parking.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                    color: Color(0xff494949)))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
                //Additional Description
                Container(
                  margin: EdgeInsets.only(top: 10),
                  color: ColorData.primaryColor,
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  child: BuildText(
                    text: "Additional Description",
                    color: Colors.white,
                  ),
                ),

                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    args.description.toString(),
                    softWrap: true,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  color: ColorData.primaryColor,
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  child: BuildText(
                    text: "Location",
                    color: Colors.white,
                  ),
                ),

                Container(
                  height: height * 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[200],
                  ),
                  child: GoogleMap(
                    compassEnabled: false,
                    mapType: MapType.normal,
                    trafficEnabled: false,
                    buildingsEnabled: false,
                    mapToolbarEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _googleMapController = controller;
                    },
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    markers: {
                      Marker(
                        markerId: MarkerId('Location'),
                        position: LatLng(
                          args.latitude,
                          args.longitude,
                        ),
                      )
                    },
                    initialCameraPosition: CameraPosition(
                      bearing: 0.0,
                      target: LatLng(
                        args.latitude,
                        args.longitude,
                      ),
                      zoom: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 75.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: Color(0XFF2FB7B2).withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? Color(0XFF6BC4C9) : Color(0XFFEAEAEA),
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
