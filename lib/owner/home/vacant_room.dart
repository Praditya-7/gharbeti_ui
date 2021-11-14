import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/color.dart';

class VacantRoom extends StatefulWidget {
  const VacantRoom({Key? key}) : super(key: key);

  @override
  _VacantRoomState createState() => _VacantRoomState();
}

class _VacantRoomState extends State<VacantRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorData.primaryColor,
        title: Text("Vacant Listing"),
      ),
    );
  }
}
