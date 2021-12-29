import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/tenant/discover/entity/locationRadius_container.dart';
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
  List<Room> roomList = [];
  final TextEditingController radiusController = TextEditingController();
  double width = 0.0;
  double height = 0.0;
  LatLng? _latLng;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      appBar: AppBar(
        backgroundColor: const Color(0xff09548c),
        title: const Text("Search within Location"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if (_latLng == null || radiusController.text.toString() == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mark a location and Enter Radius'),
                  ),
                );
              } else {
                LocationRadius_container popData = LocationRadius_container(
                  markedLocation: _latLng,
                  radius: radiusController.text.toString(),
                );
                Navigator.pop(context, popData);
              }
            },
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(10.0),
            child: Container(
              height: height * 85,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding: const EdgeInsets.fromLTRB(18, 2, 30, 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Enter the Search Radius (in km)'),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.number,
                            controller: radiusController,
                            cursorColor: const Color(0xff09548c),
                            decoration: const InputDecoration(
                              hintText: "Enter Here",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
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
                      onTap: (point) {
                        setState(() {
                          _marker = {
                            Marker(
                              markerId: const MarkerId('Pin'),
                              icon: BitmapDescriptor.defaultMarker,
                              position: point,
                            )
                          };
                          _latLng = point;
                        });
                      },
                      initialCameraPosition: const CameraPosition(
                        bearing: 0.0,
                        target: LatLng(
                          27.7172,
                          85.3240,
                        ),
                        zoom: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
