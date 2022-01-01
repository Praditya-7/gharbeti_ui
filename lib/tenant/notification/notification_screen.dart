// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gharbeti_ui/owner/billing/entity/billing_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/tenant/notification/notification_widget.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class NotificationScreen extends StatefulWidget {
  static String route = '/notificationScreen';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Billings> billingList = [];
  double width = 0.0;
  double height = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: ColorData.primaryColor,
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 1,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 0.1,
                  indent: 0,
                  thickness: 0.1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return NotificationWidget(
                    height: height,
                    width: width,
                    // data: billingList[index],
                    index: index,
                    onTap: (index) {
                      //ROUTE CODE HERE
                    },
                  );
                },
              ),
            ),
            Visibility(
              visible: isLoading,
              child: CustomProgressIndicatorWidget(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
