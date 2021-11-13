// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class RecentPayment extends StatefulWidget {
  const RecentPayment({Key? key}) : super(key: key);

  @override
  _RecentPaymentState createState() => _RecentPaymentState();
}

class _RecentPaymentState extends State<RecentPayment> {
  @override
  Widget build(BuildContext context) {
    String paymentStatus = "Complete";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text("Recent Payments"),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Payment 1
            Container(
              margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10),
              padding: EdgeInsets.all(10.0),
              color: Color(0xffF4F5F9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Rs. 9000.00',
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
                        'Monthly Rent: Bhadra',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Payment By'),
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
                      Text(
                        'Ram Shrestha',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), //Type of Payment
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        paymentStatus,
                        style: TextStyle(
                          color: paymentStatus == 'Complete' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //Payment 2
            Container(
              margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10),
              padding: EdgeInsets.all(10.0),
              color: Color(0xffF4F5F9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Rs. 9000.00',
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
                        'Monthly Rent: Bhadra',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Payment By'),
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
                      Text(
                        'Ram Shrestha',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), //Type of Payment
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        paymentStatus,
                        style: TextStyle(
                          color: paymentStatus == 'Complete' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //Payment 3
            Container(
              margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10),
              padding: EdgeInsets.all(10.0),
              color: Color(0xffF4F5F9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Rs. 9000.00',
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
                        'Monthly Rent: Bhadra',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Payment By'),
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
                      Text(
                        'Ram Shrestha',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), //Type of Payment
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        paymentStatus,
                        style: TextStyle(
                          color: paymentStatus == 'Complete' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //Payment 4
            Container(
              margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10),
              padding: EdgeInsets.all(10.0),
              color: Color(0xffF4F5F9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Rs. 9000.00',
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
                        'Monthly Rent: Bhadra',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Payment By'),
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
                      Text(
                        'Ram Shrestha',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), //Type of Payment
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        paymentStatus,
                        style: TextStyle(
                          color: paymentStatus == 'Complete' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //payment 5
            Container(
              margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10),
              padding: EdgeInsets.all(10.0),
              color: Color(0xffF4F5F9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Rs. 9000.00',
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
                        'Monthly Rent: Bhadra',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Payment By'),
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
                      Text(
                        'Ram Shrestha',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ), //Type of Payment
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        paymentStatus,
                        style: TextStyle(
                          color: paymentStatus == 'Complete' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
