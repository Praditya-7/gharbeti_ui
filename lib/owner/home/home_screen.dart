// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/occupied_room.dart';
import 'package:gharbeti_ui/owner/home/vacant_room.dart';

class HomeScreenOwner extends StatefulWidget {
  static const route = "/homeScreenOwner";
  const HomeScreenOwner({Key? key}) : super(key: key);

  @override
  State<HomeScreenOwner> createState() => _HomeScreenOwnerState();
}

class _HomeScreenOwnerState extends State<HomeScreenOwner> {
  int roomCount = 2;
  int vacantCount = 1;
  int occupiedCount = 1;
  String rentMonth = 'October';
  String paymentStatus = 'Complete';
  int monthlyRent = 9000;
  String tenantName = 'Sarthak Shrestha';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Room Info",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 135,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffC4D7E4),
                            ),
                            child: Center(
                              child: Text(
                                "$roomCount\nTotal",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Vacant Room Indicator
                              InkWell(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      color: Color(0xff30D472),
                                      child: Text(
                                        vacantCount.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "Vacant",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VacantRoom()));
                                },
                              ),
                              SizedBox(height: 25.0),
                              InkWell(
                                  child: Row(
                                    children: [
                                      //Occupied Indicator
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        color: Color(0xffF6821E),
                                        child: Text(
                                          occupiedCount.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        "Occupied",
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OccupiedRoom()));
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Payment Status",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
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
                                'Monthly Rent:' + rentMonth,
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.picture_as_pdf,
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
                            'Payment By',
                          ),
                          Text(
                            tenantName,
                            style: TextStyle(
                              color: Color(0xff09548c),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Payment Status'),
                          Text(
                            paymentStatus,
                            style: TextStyle(
                              color: paymentStatus == 'Complete'
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
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
                              Text('Monthly Rent:' + rentMonth),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.picture_as_pdf,
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
                          Text('Payment By'),
                          Text(
                            tenantName,
                            style: TextStyle(
                              color: Color(0xff09548c),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Payment Status'),
                          Text(
                            paymentStatus,
                            style: TextStyle(
                              color: paymentStatus == 'Complete'
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
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
                              Text('Monthly Rent:' + rentMonth),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.picture_as_pdf,
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
                          Text('Payment By'),
                          Text(
                            tenantName,
                            style: TextStyle(
                              color: Color(0xff09548c),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Payment Status'),
                          Text(
                            paymentStatus,
                            style: TextStyle(
                              color: paymentStatus == 'Complete'
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {},
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
