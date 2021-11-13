// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingBills extends StatefulWidget {
  const PendingBills({Key? key}) : super(key: key);

  @override
  _PendingBillsState createState() => _PendingBillsState();
}

class _PendingBillsState extends State<PendingBills> {
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
                              size: 33,
                              color: Color(0xff09548c),
                            ),
                            onPressed: () {
                              //ROUTE TO PDF PAGE HERE
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.deepOrangeAccent,
                          ),
                          child: InkWell(
                            onTap: () {
                              //Add room Function
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Pay Now',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
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
