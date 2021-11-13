// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentPayments extends StatefulWidget {
  const RecentPayments({Key? key}) : super(key: key);

  @override
  _RecentPaymentsState createState() => _RecentPaymentsState();
}

class _RecentPaymentsState extends State<RecentPayments> {
  String rentMonth = 'October';
  final List<String> entries = <String>[
    'January',
    'February',
  ];
  String paymentStatus = 'Complete';
  int totalDueBalance = 8000;
  int monthlyRent = 4000;
  String status = 'Paid';
  String tenantName = 'Sarthak Shrestha';
  String paymentOption = 'Khalti';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text('Pending Bills'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.message),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: entries.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 0.1,
                indent: 0,
                thickness: 0.1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  color: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      //Monthly Rent and PDF
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rs. ' + monthlyRent.toString(),
                                style: TextStyle(
                                  color: Color(0xff09548c),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Rent Month: ' + rentMonth,
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.picture_as_pdf,
                              size: 35,
                              color: Color(0xff09548c),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Option',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            paymentOption,
                            style: TextStyle(
                              color: Color(0xff09548c),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Status',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            paymentStatus,
                            style: TextStyle(
                              color: paymentStatus == 'Complete' ? Colors.green : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
