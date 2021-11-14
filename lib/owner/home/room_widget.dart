import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';

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
          )
        ],
      ),
    );
  }
}
