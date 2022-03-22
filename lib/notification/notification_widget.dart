import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/notification/entity/notification_container.dart';
import 'package:gharbeti_ui/owner/billing/entity/billing_container.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class NotificationWidget extends StatefulWidget {
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
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  Billings document = Billings();
  Notifications notificationDoc = Notifications();
  String option = "";
  @override
  Widget build(BuildContext context) {
    var unformattedDate = widget.data.time?.toDate();

    String formattedTime =
        DateFormat.yMMMMd().format(unformattedDate!).toString();
    //
    if (widget.data.status == "Pending" || widget.data.status == "Paid") {
      return SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(12),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/logo_image.png',
                    width: widget.width * 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.title.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.data.body.toString(),
                        softWrap: true,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              //Time
              Text(
                formattedTime,
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      );
    } else if (widget.data.status == "Request") {
      return SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Image and Msg
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image/logo_image.png',
                    width: widget.width * 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.title.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.data.body.toString(),
                        softWrap: true,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              //Time
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          option = 'Yes';
                        },
                      );
                      billingQuery();
                      notificationQuery();
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: option == 'Yes'
                            ? const Color(0xff09548c)
                            : const Color(0xffEEEEEE),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Text(
                          'Yes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                option == 'Yes' ? Colors.white : Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          option = 'No';
                        },
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: option == 'No'
                            ? Color(0xff09548c)
                            : Color(0xffEEEEEE),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: option == 'No' ? Colors.white : Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  notificationQuery() async {
    final pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");

    var query = _fireStore
        .collection('Notifications')
        .where("To", isEqualTo: widget.data.to)
        .where("From", isEqualTo: widget.data.from)
        .where("Month", isEqualTo: widget.data.month)
        .where("Time", isEqualTo: widget.data.time)
        .get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          notificationDoc = Notifications.fromFireStoreSnapshot(doc);
        }
      }
    });
    await _fireStore
        .collection('Notifications')
        .doc(notificationDoc.documentId)
        .update({"Status": "Paid"}).then((value) {
      print("Notification Status changed");
    });
  }

  billingQuery() async {
    var query = _fireStore
        .collection('Billings')
        .where("OwnerEmail", isEqualTo: widget.data.to)
        .where("TenantEmail", isEqualTo: widget.data.from)
        .where("Month", isEqualTo: widget.data.month)
        .get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          document = Billings.fromFireStoreSnapshot(doc);
        }
      }
    });
    await _fireStore
        .collection('Billings')
        .doc(document.documentId)
        .update({"Status": "Paid"}).then((value) {
      print("Billing Status changed");
    }).catchError(
      (error) => print("Failed to add data: $error"),
    );
  }
}
