// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/billing/owner_billing_widget.dart';
import 'package:gharbeti_ui/owner/billing/owner_paid_bills.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'entity/billing_container.dart';
import 'issue_monthly_bill.dart';
import 'owner_pending_bills.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class BillingScreenOwner extends StatefulWidget {
  const BillingScreenOwner({Key? key}) : super(key: key);

  @override
  State<BillingScreenOwner> createState() => _BillingScreenOwnerState();
}

class _BillingScreenOwnerState extends State<BillingScreenOwner> {
  double width = 0.0;
  double height = 0.0;
  String paymentStatus = "Complete";
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
        .where("OwnerEmail", isEqualTo: email)
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
      pendingList.clear();
    });

    var query2 = _fireStore
        .collection('Billings')
        .where("OwnerEmail", isEqualTo: email)
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
      paidList.clear();
    });

    setState(() {
      pendingList.isNotEmpty ? pendingData = pendingList.first : null;
      paidList.isNotEmpty ? paidData = paidList.first : null;
      pendingCount = pendingList.length;
      print(pendingCount);
      paidCount = paidList.length;
      print(paidCount);
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
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                      child: Text(
                        "Issued Bill",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),
                      ),
                    ),
                    pendingList.isNotEmpty
                        ? OwnerBillingWidget(
                            width: width,
                            height: height,
                            data: pendingData,
                          )
                        : Container(
                            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10),
                            height: height * 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                                  Navigator.of(context).pushNamed(OwnerPendingBills.route);
                                },
                                child: Text(
                                  "View All >",
                                  style: TextStyle(color: Color(0xff09548C)),
                                ),
                              )
                            : Container(),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                      child: Text(
                        "Recent Payments",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),
                      ),
                    ),
                    //Paid Bills
                    paidList.isNotEmpty
                        ? OwnerBillingWidget(
                            width: width,
                            height: height,
                            data: paidData,
                          )
                        : Container(
                            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                                  Navigator.of(context).pushNamed(OwnerPaidBills.route);
                                },
                                child: Text(
                                  "View All >",
                                  style: TextStyle(color: Color(0xff09548C)),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff09548C),
                        ),
                        icon: Icon(
                          Icons.receipt,
                          color: Colors.white,
                        ),
                        label: Text('Issue Monthly Bill'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IssueMonthlyBill(),
                            ),
                          );
                        },
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
