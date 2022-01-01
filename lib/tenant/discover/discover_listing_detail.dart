// ignore_for_file: prefer_const_constructors
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'carousel.dart';

class DiscoverListingDetail extends StatefulWidget {
  static String route = '/discoverListingDetail';
  const DiscoverListingDetail({Key? key}) : super(key: key);

  @override
  _DiscoverListingDetailState createState() => _DiscoverListingDetailState();
}

class _DiscoverListingDetailState extends State<DiscoverListingDetail> {
  Room args = Room(latitude: 0, longitude: 0);
  late GoogleMapController _googleMapController;
  int _currentPage = 0;
  PageController _pageController = PageController();

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
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text("Listing Detail"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
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
              //CALL FUNCTION
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
                // Container(
                //   color: Colors.white,
                //   child: Image.network(
                //     args.imagesLinkList!.first.toString(),
                //     fit: BoxFit.fitWidth,
                //     width: double.infinity,
                //     height: height * 30,
                //   ),
                // ),

                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: height * 30,
                  child: Stack(
                    children: [
                      CarouselWithIndicator(imgList: args.imagesLinkList,),
                      Positioned(
                        left: width * 35,
                        top: height * 28,
                        child: Center(
                          child: Text(
                            'Swipe for more images',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
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
                                address,
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
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
                          Text("Owner",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          Text(name),
                        ],
                      ),
                      //Preferences
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Preferences",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          Text(args.preferences.toString()),
                        ],
                      ),
                      //Floor
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Floor",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          Text(args.floor.toString()),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                //Basic Amenities
                Text(
                  "Basic Amenities",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
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
                              fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.black),
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
                              fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.black),
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
                              fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.black),
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
                              fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.black),
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
                //Basic Amenities
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Additional Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Text(args.description.toString()),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Location",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
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
