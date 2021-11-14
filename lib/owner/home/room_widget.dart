import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';

class RoomWidget extends StatelessWidget {
  final int index;
  final double width;
  final double height;
  final Room data;
  final Function(int index) onTap;

  const RoomWidget({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: width * 20,
            height: width * 30,
            decoration: BoxDecoration(
              color: index % 2 == 0
                  ? Colors.green.withOpacity(0.5)
                  : Colors.red.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildText(
                text: "ROOM NO ${data.listingNo}",
                weight: FontWeight.w600,
                fontSize: 18,
              ),
              SizedBox(height: 10),
              BuildText(
                text: "${data.address}, ${data.city}",
                weight: FontWeight.w300,
                fontSize: 14,
              ),
              SizedBox(height: 10),
              BuildText(
                text: "Preferences: ${data.preference}",
                weight: FontWeight.w300,
                fontSize: 14,
              )
            ],
          ),
          Icon(
            Icons.location_on,
            size: width * 10,
            color: ColorData.primaryColor,
          )
        ],
      ),
    );
  }
}
