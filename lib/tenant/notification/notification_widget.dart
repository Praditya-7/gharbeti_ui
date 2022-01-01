import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  final int index;
  final double width;
  final double height;
  // final Billings data;
  final Function(int index) onTap;

  const NotificationWidget({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    // required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text('NOTIFICATION'),
      ),
    );
  }
}
