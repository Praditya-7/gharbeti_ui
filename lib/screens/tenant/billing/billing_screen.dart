// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  _BillingScreenState createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  int dueBalance = 8000;
  String status = 'Paid';
  late String balance = dueBalance.toString();
  String month = 'Kartik';
  final List<String> entries = <String>[
    'Baishak',
    'Jestha',
    'Ashar',
    'Shrawan',
    'Bhadra',
    'Ashwin',
  ];
  String paymentStatus = 'Complete';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.filter_list_alt,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff09548c),
      ), // appBar: ReusableWidgets.getAppBar(title),
      body: SafeArea(
        child: Column(
          children: [
            //First Container
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(10, 15.0, 10, 10),
              padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Balance Due'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Rs. ' + balance + '.00',
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
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.white, // <-- Button color
                    ),
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
            // Second Container
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 0.1,
                  indent: 0,
                  thickness: 0.1,
                ),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(10, 0.0, 10, 10),
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rs. ' + balance + '.00',
                              style: TextStyle(
                                color: Color(0xff09548c),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_adjacent_string_concatenation
                              'Monthly Rent: ' + entries[index],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Payment System'),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Payment Status'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            IconButton(
                              iconSize: 35,
                              padding: EdgeInsets.all(10),
                              icon: Icon(
                                Icons.picture_as_pdf,
                                color: Color(0xff09548c),
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Online Payment'), //Type of Payment
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              paymentStatus,
                              style: TextStyle(
                                color: paymentStatus == 'Complete'
                                    ? Colors.green
                                    : Colors.red,
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
          ],
        ),
      ),
    );
  }
}
