// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class TenantDetail extends StatefulWidget {
  static String route = '/tenantDetail';
  const TenantDetail({Key? key}) : super(key: key);

  @override
  _TenantDetailState createState() => _TenantDetailState();
}

class _TenantDetailState extends State<TenantDetail> {
  late String name = 'Ram Shrestha';
  late String address = 'Kathmandu';
  late String email = 'shrestharam@gmail.com';
  late String gender = 'Male';
  late int contact = 988634269;
  late int emContact = 988634269;
  late String listType = 'Room';
  late int listingNo = 402;
  late int tid = 1001;
  String paymentStatus = 'pending';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 20.0,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff09548C),
            ),
            icon: Icon(
              Icons.call,
              color: Colors.white,
            ),
            label: Text('Call Now'),
            onPressed: () {
              //CALL FUNCTION
            },
          ),
          SizedBox(
            width: 10.0,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff09548C),
            ),
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
            label: Text('Message'),
            onPressed: () {
              //MESSAGE FUNCTION HERE
            },
          ),
        ],
      ),

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     InkWell(
      //       onTap: () {},
      //       child: Container(
      //         height: 38,
      //         padding: EdgeInsets.all(10),
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(5),
      //           color: Color(0xff09548c),
      //         ),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             Icon(
      //               Icons.call,
      //               color: Colors.white,
      //             ),
      //             SizedBox(width: 5),
      //             Text(
      //               'Call Now',
      //               style: TextStyle(
      //                 color: Colors.white,
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //     InkWell(
      //       onTap: () {},
      //       child: Container(
      //         padding: EdgeInsets.all(10),
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(5),
      //           color: Color(0xff09548c),
      //         ),
      //         child: Row(
      //           children: [
      //             Icon(
      //               Icons.message,
      //               color: Colors.white,
      //             ),
      //             SizedBox(width: 5),
      //             Text(
      //               'Message',
      //               style: TextStyle(
      //                 color: Colors.white,
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text("Tenant Details"),
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              color: Colors.white,
              child: Column(
                children: [
                  Center(
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
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Details",
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
                          //DELETE FUNCTION
                        },
                      ),
                    ],
                  ),
                  //Email
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Email
                        RichText(
                          text: TextSpan(
                            text: "Email : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " " + email,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      color: Color(0xff494949)))
                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        //Address
                        RichText(
                          text: TextSpan(
                            text: "Address : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " " + address,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      color: Color(0xff494949)))
                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        //Gender
                        RichText(
                          text: TextSpan(
                            text: "Gender : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " " + gender,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      color: Color(0xff494949)))
                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        //Contact
                        RichText(
                          text: TextSpan(
                            text: "Contact : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " " + contact.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      color: Color(0xff494949)))
                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        //Emergency Contact
                        RichText(
                          text: TextSpan(
                            text: "Emergency Contact : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " " + emContact.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      color: Color(0xff494949)))
                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        //Listing type
                        RichText(
                          text: TextSpan(
                            text: "Listing Type : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " " + listType,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      color: Color(0xff494949)))
                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        //Listing No
                        RichText(
                          text: TextSpan(
                            text: "Listing No : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " " + listingNo.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      color: Color(0xff494949)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8.0),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                      child: Text(
                        "Pending Bills",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //Pending Bills
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10),
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
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
                              Text('Bill Date'),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Payment Status'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                '25 Bhadra,2078',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ), //Type of Payment
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                paymentStatus,
                                style: TextStyle(
                                  color: paymentStatus == 'Complete'
                                      ? Colors.green
                                      : Color(0xffF6821E),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
