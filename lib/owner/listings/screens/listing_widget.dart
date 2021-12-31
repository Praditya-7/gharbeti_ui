import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/owner/listings/screens/listing_detail.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListingWidget extends StatelessWidget {
  final int index;
  final double width;
  final double height;
  final Room data;
  final Function(int index) onTap;

  const ListingWidget({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final pref = await SharedPreferences.getInstance();
        pref.setString("TenantEmail", data.tenantEmail.toString());
        Navigator.of(context).pushNamed(ListingDetail.route, arguments: data);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data.imagesLinkList!.first.toString(),
                fit: BoxFit.cover,
                width: width * 33,
                height: height * 17,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildText(
                  text: "${data.type} No.${data.listingNo}",
                  weight: FontWeight.w600,
                  fontSize: 18,
                ),
                const SizedBox(
                  height: 10,
                ),
                BuildText(
                  text: "Floor: ${data.floor}",
                  weight: FontWeight.normal,
                  fontSize: 14,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      'Status : ',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: data.status == 'Vacant' ? const Color(0xff30d472) : Colors.orange,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            data.status.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
