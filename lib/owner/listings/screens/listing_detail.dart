// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';

class ListingDetail extends StatefulWidget {
  static String route = '/listingDetail';
  const ListingDetail({Key? key}) : super(key: key);

  @override
  _ListingDetailState createState() => _ListingDetailState();
}

class _ListingDetailState extends State<ListingDetail> {
  Room args = Room(latitude: 0, longitude: 0);

  String name = 'Ram Shrestha';
  int tid = 1001;
  int roomNo = 420;
  String floor = "First";
  int bathroom = 1;
  int kitchen = 1;
  String date = "2021/01/01";
  int rent = 9000;
  int electricityCharge = 1000;
  int lastMeterReading = 230;
  int waterCharge = 500;
  int internetCharge = 1500;

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as Room;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text("Room Details"),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(8.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.meeting_room_sharp,
                            size: 60,
                            color: Colors.black,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Room No " + args.listingNo.toString(),
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "Status : ",
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF6821E),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    args.status.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Room Info",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 120.0,
                        ),
                        InkWell(
                          child: Icon(Icons.edit),
                          onTap: () {
                            //EDIT FUNCTION
                          },
                        ),
                        InkWell(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onTap: () {
                            //Delete Function
                          },
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Floor : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " " + args.floor.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Bathroom : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " " + args.bathroom.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Kitchen : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " " + args.kitchen.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),

                          //ADD START DATE WHEN ADDING TENANT

                          RichText(
                            text: TextSpan(
                              text: "Start Date : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " " + date.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Rent : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " Rs." + args.rent.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 5.0, 0, 0),
                      child: Text(
                        "Electricity Charge",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Per Unit Charge (in Rs) : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " " + electricityCharge.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Last Meter Reading : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " " + lastMeterReading.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 5.0, 0, 0),
                      child: Text(
                        "Water Charge",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Monthly Charge (in Rs) : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " " + waterCharge.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 5.0, 0, 0),
                      child: Text(
                        "Internet Charge",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Monthly Charge (in Rs) : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " " + internetCharge.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Color(0xff494949)))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Occupied By
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 5.0, 0, 0),
                  child: Text(
                    "Ocuupied By",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),
                  )),
              Container(
                margin: EdgeInsets.all(8.0),
                color: Colors.white,
                child: Center(
                  child: ListTile(
                    leading: Container(
                      width: 75,
                      height: 200,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://googleflutter.com/sample_image.jpg',
                          ),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    title:
                        Text(name, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      "TID" + tid.toString(),
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
