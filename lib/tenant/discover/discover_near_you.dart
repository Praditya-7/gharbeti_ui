// ignore_for_file: prefer_const_constructors
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoverNearYou extends StatefulWidget {
  static String route = '/discoverNearYou';
  const DiscoverNearYou({Key? key}) : super(key: key);

  @override
  _DiscoverNearYouState createState() => _DiscoverNearYouState();
}

class _DiscoverNearYouState extends State<DiscoverNearYou> {
  Set<Marker> _marker = <Marker>{};
  late GoogleMapController _googleMapController;

  double width = 0.0;
  double height = 0.0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text("Near You"),
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Container(
              height: height * 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[200],
              ),
              child: GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _googleMapController = controller;
                },
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
                markers: _marker,
                circles: {
                  Circle(
                    circleId: CircleId('Near Me'),
                    fillColor: Colors.redAccent,
                    radius: 10000,
                  ),
                },
                initialCameraPosition: CameraPosition(
                  bearing: 0.0,
                  target: LatLng(
                    27.7172,
                    85.3240,
                  ),
                  zoom: 12.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
