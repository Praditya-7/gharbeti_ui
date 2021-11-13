// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gharbeti_ui/screens/tenant/billing/pending_bills.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  _BillingScreenState createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  int totalDueBalance = 8000;
  int monthlyRent = 4000;
  String status = 'Paid';
  String tenantName = 'Sarthak Shrestha';
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
  String paymentStatus = 'Complete';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: SingleChildScrollView(
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
                            ) {},
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
                Container(
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
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PendingBills(),
                        ),
                      );
                    },
                    child: Text(
                      'View All >>',
                      style: TextStyle(
                        color: Color(0xff09548c),
                      ),
                    ),
                  ),
                ),

                //RECENT PAYMENT
                Text(
                  'Recent Payment',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
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
                ),
                SizedBox(height: 10),
                Container(
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
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      //ROUTE TO RECENT PAYMENT
                    },
                    child: Text(
                      'View All >>',
                      style: TextStyle(
                        color: Color(0xff09548c),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
