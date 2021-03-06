// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/billing/owner_billing_widget.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'entity/billing_container.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class OwnerPaidBills extends StatefulWidget {
  static String route = '/ownerPaidBills';
  const OwnerPaidBills({Key? key}) : super(key: key);

  @override
  _OwnerPaidBillsState createState() => _OwnerPaidBillsState();
}

class _OwnerPaidBillsState extends State<OwnerPaidBills> {
  double width = 0.0;
  double height = 0.0;
  List<Billings> billingList = [];
  List<Billings> paidList = [];
  bool isLoading = true;
  int paidCount = 0;
  int billCount = 0;

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    billingList.clear();
    final pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    var query = _fireStore
        .collection('Billings')
        .where("OwnerEmail", isEqualTo: email)
        .get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          billingList.add(Billings.fromFireStoreSnapshot(doc));
        }
      }
    });
    paidList.clear();
    for (var item in billingList) {
      if (item.status.toString() == 'Paid') {
        paidList.add(item);
      }
    }
    setState(() {
      billCount = billingList.length;
      paidCount = paidList.length;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text("Paid Bills"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: paidList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 0.1,
                    indent: 0,
                    thickness: 0.1,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return OwnerBillingWidget(
                      height: height,
                      width: width,
                      data: paidList[index],
                    );
                  },
                ),
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
}
