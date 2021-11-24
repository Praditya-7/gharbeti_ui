import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';
import 'package:gharbeti_ui/owner/tenants/tenant_detail.dart';

class TenantScreenWidget extends StatelessWidget {
  final int index;
  final double width;
  final double height;
  final User tenantData;
  final Room roomData;
  final Function(int index) onTap;

  const TenantScreenWidget({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    required this.tenantData,
    required this.roomData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String tenantName = 'Ram Shrestha';
    String listingType = 'Flat';
    List<int> dueRemaining = [
      15000,
      0,
      1600,
    ];

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(TenantDetail.route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Icon(
                  Icons.person,
                  color: Color(0xff09548c),
                  size: 100,
                ),
                Text(
                  tenantData.name.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  roomData.type.toString() + ' No. ' + tenantData.roomName.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      'Due: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      //ERROR HERE IN DUE VALUE
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: (dueRemaining[index] == 0) ? Color(0xff30d472) : Colors.orange,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            dueRemaining[index].toString(),
                            style: TextStyle(
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
