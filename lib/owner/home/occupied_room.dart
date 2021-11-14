import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/color.dart';

class OccupiedRoom extends StatefulWidget {
  const OccupiedRoom({Key? key}) : super(key: key);

  @override
  _OccupiedRoomState createState() => _OccupiedRoomState();
}

class _OccupiedRoomState extends State<OccupiedRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(ColorData.primaryColor),
        title: Text("Occupied Listing"),
      ),
    );
  }
}
