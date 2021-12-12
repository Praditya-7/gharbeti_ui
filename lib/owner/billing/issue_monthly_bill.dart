// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gharbeti_ui/owner/billing/entity/billing_container.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class IssueMonthlyBill extends StatefulWidget {
  const IssueMonthlyBill({Key? key}) : super(key: key);

  @override
  _IssueMonthlyBillState createState() => _IssueMonthlyBillState();
}

class _IssueMonthlyBillState extends State<IssueMonthlyBill> {
  bool isLoading = true;
  int? index;
  String? tenantDropdownValue;
  String? billMonthDropdownValue = 'January';
  int rentCharge = 0;
  int? dueRemaining = 0;
  int perUnitElectricityCharge = 15;
  int lastMeterReading = 230;
  int diff = 0;
  int current = 0;
  int cost = 0;
  int waterCharge = 500;
  int internetCharge = 1500;
  int total = 0;
  List<Room> roomList = [];
  List<Room> occupiedList = [];
  List<String?> tenantList = [];
  List<String?> rentList = [];
  final TextEditingController currentMeterReading = TextEditingController();
  final pdf = pw.Document();

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    roomList.clear();
    final pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    var query = _fireStore
        .collection('Rooms')
        .where("OwnerEmail", isEqualTo: email)
        .get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          roomList.add(Room.fromFireStoreSnapshot(doc));
        }
      }
    });
    occupiedList.clear();
    for (var item in roomList) {
      if (item.status == "Occupied") {
        occupiedList.add(item);
        tenantList.add(item.tenantEmail);
        rentList.add(item.rent);
        print(tenantList[0]);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text('Issue Bill'),
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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Billing Detail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //Billing Detail Start
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Select Tenant
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Tenant*',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              underline: Container(
                                height: 0,
                              ),
                              value: tenantDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  tenantDropdownValue = newValue!;
                                  for (int i = 0; i < tenantList.length; i++) {
                                    if (tenantDropdownValue == tenantList[i]) {
                                      index = i;
                                    }
                                  }
                                  rentCharge =
                                      int.parse(rentList[index!].toString());
                                });
                              },
                              icon: Icon(Icons.arrow_drop_down_sharp),
                              items: tenantList.map((String? value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value!),
                                );
                              }).toList(),
                            ),
                          ),
                          //Select Tenant End
                          //Bill Month Start
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Bill Month'),
                                DropdownButton<String>(
                                  underline: Container(
                                    height: 0,
                                  ),
                                  value: billMonthDropdownValue,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      billMonthDropdownValue = newValue!;
                                    });
                                  },
                                  icon: Icon(Icons.arrow_drop_down_sharp),
                                  items: <String>[
                                    'January',
                                    'February',
                                    'March',
                                    'April',
                                    'May',
                                    'June',
                                    'July',
                                    'August',
                                    'September',
                                    'October',
                                    'November',
                                    'December',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          //Bill Month End
                          //Monthly Rent Start
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Monthly Rent'),
                                Text('Rs. ' + rentCharge.toString()),
                              ],
                            ),
                          ),
                          //Monthly Rent End
                          //Remaining Dues
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Remaining Dues'),
                                Text('Rs. ' + dueRemaining.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Billing Detail End
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Electricity Charge',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Per Unit Charge
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            padding: EdgeInsets.fromLTRB(18, 2, 30, 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Per Unit Charge(in Rs.)'),
                                SizedBox(
                                  width: 100,
                                  child: TextField(
                                    textAlign: TextAlign.end,
                                    keyboardType: TextInputType.number,
                                    controller: currentMeterReading,
                                    cursorColor: Color(0xff09548c),
                                    onChanged: (value) {
                                      setState(() {
                                        perUnitElectricityCharge = value as int;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter Here",
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Last Meter Reading
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Last Meter Reading'),
                                Text(lastMeterReading.toString()),
                              ],
                            ),
                          ),
                          //Current Meter Reading
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            padding: EdgeInsets.fromLTRB(18, 2, 30, 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Current Meter Reading'),
                                SizedBox(
                                  width: 100,
                                  child: TextField(
                                    textAlign: TextAlign.end,
                                    keyboardType: TextInputType.number,
                                    controller: currentMeterReading,
                                    cursorColor: Color(0xff09548c),
                                    onChanged: (value) {
                                      setState(() {
                                        current =
                                            int.parse(currentMeterReading.text);
                                        diff = current - lastMeterReading;
                                        cost = diff * perUnitElectricityCharge;
                                        total = cost +
                                            waterCharge +
                                            internetCharge +
                                            rentCharge;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter Here",
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Consumed Unit
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                            padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Consumed Unit'),
                                Text(diff.toString()),
                              ],
                            ),
                          ),
                          //Total Cost
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Cost'),
                                Text('Rs.' + cost.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //End of Electricity Charge
                    //Water Charge
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Water Charge',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Water Charge
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            padding: EdgeInsets.fromLTRB(18, 2, 30, 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Water Charge(in Rs.)'),
                                SizedBox(
                                  width: 100,
                                  child: TextField(
                                    textAlign: TextAlign.end,
                                    keyboardType: TextInputType.number,
                                    controller: currentMeterReading,
                                    cursorColor: Color(0xff09548c),
                                    onChanged: (value) {
                                      setState(() {
                                        waterCharge = value as int;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter Here",
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //End of Water Charge
                    //Internet Charge
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Internet Charge',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Water Charge
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            padding: EdgeInsets.fromLTRB(18, 2, 30, 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Internet Charge(in Rs.)'),
                                SizedBox(
                                  width: 100,
                                  child: TextField(
                                    textAlign: TextAlign.end,
                                    keyboardType: TextInputType.number,
                                    controller: currentMeterReading,
                                    cursorColor: Color(0xff09548c),
                                    onChanged: (value) {
                                      setState(() {
                                        internetCharge = value as int;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter Here",
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //End of Internet Charge
                    SizedBox(
                      height: 5,
                    ),
                    //Total
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                        child: Center(
                          child: Text(
                            'Total Rs.' + total.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //Issue to Tenant
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff09548c),
                      ),
                      child: InkWell(
                        onTap: () async {
                          setState(() async {
                            writeOnPdf();
                            await savePdf();
                            /* Directory? documentDirectory =
                                await getExternalStorageDirectory();
                            String documentPath = documentDirectory!.path;
                            String fullPath = "$documentPath/example.pdf";
                            print(fullPath);*/
                            setBillData();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                          child: Center(
                            child: Text(
                              'Issue to Tenant',
                              style: TextStyle(
                                color: Colors.white,
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

  writeOnPdf() async {
    final profileImage = pw.MemoryImage(
        (await rootBundle.load('assets/image/logo_image.png'))
            .buffer
            .asUint8List());
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return pw.Container(
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
              pw.Image(profileImage, width: 175, height: 175),
              pw.SizedBox(height: 10.0),
              pw.Text(
                "INVOICE",
                style: pw.TextStyle(
                  fontSize: 28.0,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 15.0),
              //HEADER 1
              pw.Container(
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Bill To",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            "Invoice No",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Praditya Manandhar",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          pw.Text(
                            "101",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ]),
                    pw.SizedBox(height: 10.0),
                    //HEADER 2
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Listing",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            "Month",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Room 1011",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          pw.Text(
                            "January",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ]),
                  ])),
              pw.SizedBox(height: 15.0),
              //METER READING & UNIT COST
              pw.Text("Meter Reading | Per unit Cost : Rs 10.0",
                  style: pw.TextStyle(
                    fontSize: 12.0,
                    fontWeight: pw.FontWeight.bold,
                  )),
              pw.SizedBox(height: 10.0),
              pw.Container(
                  padding: pw.EdgeInsets.all(10.0),
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                      borderRadius: pw.BorderRadius.circular(5.0)),
                  child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Prev Reading: 250",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.Text("Curr Reading: 500",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.Text("Consumed Units: 250",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            )),
                      ])),
              pw.SizedBox(height: 10.0),
              //BILL HEADING
              pw.Container(
                padding: pw.EdgeInsets.all(10.0),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      //BILL HEADINGS
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Expenses",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                            pw.Text("    Unit",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                            pw.Text("Rate",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                            pw.Text("Amount",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                          ]),
                      pw.Divider(thickness: 0.5),
                      //MONTHLYRENT
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Monthly Rent",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs 9000",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                          ]),
                      pw.SizedBox(height: 8.0),
                      //ELECTRICITY CHARGE
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Electricity Chrg.",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("15",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs.15",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs 1500",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                          ]),
                      //WATER CHARGE
                      pw.SizedBox(height: 8.0),
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Water Chrg.",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs 9000",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                          ]),
                      //INTERNET CHARGE
                      pw.SizedBox(height: 8.0),
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Internet Chrg.",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs 9000",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                          ]),
                      //Previous Due
                      pw.SizedBox(height: 8.0),
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Previous Dues",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs 9000",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                          ]),
                      pw.Divider(thickness: 0.5),
                      //TOTAL
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Total",
                                style: pw.TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs 9000",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                          ]),
                    ]),
              ),
              //BILLCONTENTS
              pw.SizedBox(height: 10.0),
              pw.Align(
                  alignment: pw.Alignment.bottomRight,
                  child: pw.Text("Bill From\n Shrijay Tuladhar",
                      style: pw.TextStyle(
                          fontSize: 12.0, fontWeight: pw.FontWeight.bold))),
            ]));
      },
    ));
  }

  Future savePdf() async {
    Directory? documentDirectory = await getExternalStorageDirectory();

    String documentPath = documentDirectory!.path;

    File file = File("$documentPath/example3.pdf");

    file.writeAsBytesSync(List.from(await pdf.save()));
    print(file.path.toString());
  }

  void setBillData() async {
    final pref = await SharedPreferences.getInstance();

    var model = Billings(
      ownerEmail: pref.getString("email"),
      month: billMonthDropdownValue,
      remainingDues: dueRemaining,
      electricityPerUnitCharge: perUnitElectricityCharge,
      lastMeterReading: lastMeterReading,
      currentMeterReading: int.parse(currentMeterReading.text),
      rent: rentCharge,
      consumedUnit: diff,
      totalElectricityCost: cost,
      waterCharge: waterCharge,
      total: total,
      tenantEmail: tenantDropdownValue,
      status: "Pending",
    );

    var query = _fireStore.collection('Billings').get();
    await query.then((value) {
      Map<String, dynamic> addBill = {};
      if (value.docs.isEmpty) {
        addBill = addData(model);
      } else {
        addBill = addData(model);
      }
      _fireStore.collection('Billings').add(addBill).then((value) {
        print("Data Updated");

        Navigator.pop(context);
      }).catchError((error) {
        print("Failed to add data: $error");
      });
    });
  }

  Map<String, dynamic> addData(Billings model) {
    Map<String, dynamic> data = <String, dynamic>{
      'OwnerEmail': model.ownerEmail,
      'Month': model.month,
      'RemainingDues': model.remainingDues,
      'ElectricityPerUnitCharge': model.electricityPerUnitCharge,
      'LastMeterReading': model.lastMeterReading,
      'CurrentMeterReading': model.currentMeterReading,
      'Rent': model.rent,
      'ConsumedUnit': model.consumedUnit,
      'TenantEmail': model.tenantEmail,
      'TotalElectricityCost': model.totalElectricityCost,
      'WaterCharge': model.waterCharge,
      'TotalCost': model.total,
      'Status': model.status,
    };
    return data;
  }
}
