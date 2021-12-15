// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/billing/entity/billing_container.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/tenant/billing/billing_widget.dart';
import 'package:gharbeti_ui/tenant/billing/paynow_screen.dart';
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
  int monthlyRent = 4000;
  String status = 'Paid';
  String tenantName = 'Sarthak Shrestha';
  String paymentStatus = 'Paid';
  String paymentOption = 'Khalti';
  String rentMonth = 'October';
  final List<String> entries = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
  ];
  double width = 0.0;
  double height = 0.0;
  String billStatus = "Issued";
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
      print(e);
    });

    setState(() {
      pendingList.isNotEmpty ? pendingData = pendingList.first : null;
      paidList.isNotEmpty ? paidData = paidList.first : null;
      pendingCount = pendingList.length;
      paidCount = paidList.length;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //First Container
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
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
                                  color: status == 'Paid' ? Colors.green : Colors.red,
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
                                  context, MaterialPageRoute(builder: (context) => PayNow()));
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
                    ), //Balance Due //First Container
                    // Pending Bills
                    Text(
                      'Pending Bills',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),

                    pendingList.isNotEmpty
                        ? BillingWidget(
                            width: width,
                            height: height,
                            data: pendingData,
                          )
                        : Container(
                            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10),
                            height: height * 16,
                            color: Colors.white,
                            padding: EdgeInsets.all(40),
                            child: Center(
                              child: Text('No Pending Bills found'),
                            ),
                          ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        pendingList.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(TenantPendingBills.route);
                                },
                                child: Text(
                                  "View All >",
                                  style: TextStyle(color: Color(0xff09548C)),
                                ),
                              )
                            : Container(),
                      ],
                    ),

                    //RECENT PAYMENT
                    Text(
                      'Recent Payment',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    paidList.isNotEmpty
                        ? BillingWidget(
                            width: width,
                            height: height,
                            data: paidData,
                          )
                        : Container(
                            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10),
                            color: Colors.white,
                            height: height * 16,
                            padding: EdgeInsets.all(40),
                            child: Center(
                              child: Text('No Paid Bills found'),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        paidList.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(TenantPaidBills.route);
                                },
                                child: Text(
                                  "View All >",
                                  style: TextStyle(color: Color(0xff09548C)),
                                ),
                              )
                            : Container(),
                      ],
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
