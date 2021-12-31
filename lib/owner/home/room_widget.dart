import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/owner/home/vacant_room.dart';
import 'package:gharbeti_ui/owner/listings/screens/listing_detail.dart';
import 'package:gharbeti_ui/owner/listings/service/storage_service.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';

class RoomWidget extends StatefulWidget {
  final int index;
  final double width;
  final double height;
  final Room data;
  final Function(int index) onTap;
  final String status;

  const RoomWidget({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    required this.data,
    required this.onTap,
    required this.status,
  }) : super(key: key);

  @override
  State<RoomWidget> createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<RoomWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.status == "Vacant"
              ? Navigator.of(context).pushNamed(VacantRoom.route, arguments: widget.data)
              : Navigator.of(context).pushNamed(ListingDetail.route, arguments: widget.data);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder(
              future: Storage(listingNo: widget.data.listingNo)
                  .downloadImageURL(widget.data.imageName.toString()),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                      width: widget.width * 33,
                      height: widget.height * 17,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return Container();
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildText(
                  text: "${widget.data.type} No.${widget.data.listingNo}",
                  weight: FontWeight.w600,
                  fontSize: 18,
                ),
                const SizedBox(
                  height: 10,
                ),
                BuildText(
                  text: "Floor: ${widget.data.floor}",
                  weight: FontWeight.w300,
                  fontSize: 14,
                ),
                const SizedBox(
                  height: 5,
                ),
                BuildText(
                  text: "Preferences: ${widget.data.preferences}",
                  weight: FontWeight.w300,
                  fontSize: 14,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
