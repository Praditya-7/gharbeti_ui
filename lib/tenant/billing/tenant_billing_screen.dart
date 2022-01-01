// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/billing/entity/billing_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:gharbeti_ui/tenant/billing/paynow_screen.dart';
import 'package:gharbeti_ui/tenant/billing/tenant_billing_widget.dart';
import 'package:gharbeti_ui/tenant/billing/tenant_paid_bills.dart';
import 'package:gharbeti_ui/tenant/billing/tenant_pending_bills.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class BillingTenantScreen extends StatefulWidget {
  const BillingTenantScreen({Key? key}) : super(key: key);

  @override
  _BillingTenantScreenState createState() => _BillingTenantScreenState();
}

class _BillingTenantScreenState extends State<BillingTenantScreen> {
  int totalDueBalance = 8000;
  String status = 'Paid';

  double width = 0.0;
  double height = 0.0;
  List<Billings> billingList = [];
  List<Billings> paidList = [];
  List<Billings> pendingList = [];
  Billings pendingData = Billings();
  Billings paidData = Billings();
  bool isLoading = true;
  int paidCount = 0;
  int billCount = 0;
  int pendingCount = 0;

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    pendingList.clear();
    paidList.clear();

    final pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    print(email);

    var query1 = _fireStore
        .collection('Billings')
        .where("TenantEmail", isEqualTo: email)
        .where("Status", isEqualTo: "Pending")
        .get();
    await query1.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          pendingList.add(Billings.fromFireStoreSnapshot(doc));
        }
      }
    }).catchError((e) {
      pendingList.clear();
      print(e);
    });

    var query2 = _fireStore
        .collection('Billings')
        .where("TenantEmail", isEqualTo: email)
        .where("Status", isEqualTo: "Paid")
        .get();
    await query2.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          paidList.add(Billings.fromFireStoreSnapshot(doc));
        }
      }
    }).catchError((e) {
      paidList.clear();
      print(e);
    });

    setState(() {
      print(pendingList.length);
      pendingList.isNotEmpty ? pendingData = pendingList.first : null;
      paidList.isNotEmpty ? paidData = paidList.first : null;
      pendingCount = pendingList.length;
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
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //First Container
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Balance Due'),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Rs. ' + totalDueBalance.toString() + '.00',
                            style: TextStyle(
                              color: Color(0xff09548c),
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Status: '),
                              Text(
                                status,
                                style: TextStyle(
                                  color: status == 'Paid'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: (
                                //ROUTE TO PAY NOW HERE!!
                                ) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PayNow()));
                            },
                            child: Container(
                              height: 35,
                              color: Colors.deepOrangeAccent,
                              child: Center(
                                child: Text(
                                  'Pay Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ), //Balance Due //First Container
                    // Pending Bills
                    Container(
                      color: ColorData.primaryColor,
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      child: BuildText(
                        text: "Pending Bills",
                        color: Colors.white,
                      ),
                    ),

                    pendingList.isNotEmpty
                        ? TenantBillingWidget(
                            width: width,
                            height: height,
                            data: pendingData,
                          )
                        : Container(
                            margin: EdgeInsets.all(10),
                            height: height * 16,
                            color: Colors.white,
                            padding: EdgeInsets.all(40),
                            child: Center(
                              child: Text('No Pending Bills found'),
                            ),
                          ),

                    Container(
                      margin: EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          pendingList.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(TenantPendingBills.route);
                                  },
                                  child: Text(
                                    "View All ->",
                                    style: TextStyle(color: Color(0xff09548C)),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    //RECENT PAYMENT
                    Container(
                      color: ColorData.primaryColor,
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      child: BuildText(
                        text: "Recent Payment",
                        color: Colors.white,
                      ),
                    ),
                    paidList.isNotEmpty
                        ? TenantBillingWidget(
                            width: width,
                            height: height,
                            data: paidData,
                          )
                        : Container(
                            margin: EdgeInsets.all(10),
                            color: Colors.white,
                            height: height * 16,
                            padding: EdgeInsets.all(40),
                            child: Center(
                              child: Text('No Paid Bills found'),
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          paidList.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(TenantPaidBills.route);
                                  },
                                  child: Text(
                                    "View All ->",
                                    style: TextStyle(color: Color(0xff09548C)),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
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
