import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/notification/entity/notification_container.dart';
import 'package:intl/intl.dart';

class NotificationWidget extends StatelessWidget {
  final int index;
  final double width;
  final double height;
  final Notifications data;
  final Function(int index) onTap;

  const NotificationWidget({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var unformattedDate = data.time?.toDate();
    String formattedTime =
        DateFormat.yMMMMd().format(unformattedDate!).toString();
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image and Msg
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/image/logo_image.png',
                width: width * 13,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(data.body.toString()),
                ],
              ),
            ],
          ),
          //Time
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(formattedTime),
          ),
        ],
      ),
    );
  }
}
